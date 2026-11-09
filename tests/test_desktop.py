"""Desktop migration regressions: privacy, local integrations and repeatability."""

import contextlib
import copy
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
DESKTOP = ROOT / "profiles/omarchy/desktop"
spec = importlib.util.spec_from_file_location("desktop_configure", DESKTOP / "configure.py")
desktop = importlib.util.module_from_spec(spec)
spec.loader.exec_module(desktop)


class DesktopTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="desktop-", dir=os.environ.get("TMPDIR"))
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name) / "home with spaces"
        self.config = self.home / ".config"
        (self.config / "hypr").mkdir(parents=True)
        self.backups = self.home / "backups"
        self.main = self.config / "hypr/hyprland.lua"
        self.main.write_text('require("default.hypr.omarchy")\nrequire("default.hypr.toggles")\n-- host-owned\n')
        self.preferences = json.loads((DESKTOP / "shell-preferences.json").read_text())

    def test_shell_merge_keeps_private_fields_and_unknown_widgets(self):
        current = {"idle": {"lock": 900}, "bar": {"position": "left", "layout": {
            "center": [{"id": "omarchy.clock", "birthYear": 1901}],
            "centerEnd": [{"id": "omarchy.elsewhen", "cities": [{"name": "fixture"}]}],
            "right": [{"id": "illegalstudio.omarchy-call-recorder", "microphone": "private-fixture"},
                      {"id": "local.widget", "secretSetting": "fixture"}],
        }}, "plugins": [{"id": "local.service", "option": True}]}
        before = copy.deepcopy(current)
        result = desktop.merge_shell(current, self.preferences, {"illegalstudio.omarchy-call-recorder"})
        widgets = {w["id"]: w for section in result["bar"]["layout"].values() for w in section}
        self.assertEqual(current, before)
        self.assertEqual(widgets["omarchy.clock"]["birthYear"], 1901)
        self.assertEqual(widgets["omarchy.elsewhen"]["cities"], [{"name": "fixture"}])
        self.assertEqual(widgets["illegalstudio.omarchy-call-recorder"]["microphone"], "private-fixture")
        self.assertEqual(widgets["local.widget"]["secretSetting"], "fixture")
        self.assertEqual(result["idle"], current["idle"])
        self.assertEqual(result["bar"]["position"], "left")
        self.assertEqual(result["plugins"], current["plugins"])
        self.assertEqual(desktop.merge_shell(result, self.preferences, {"illegalstudio.omarchy-call-recorder"}), result)

    def test_absent_plugins_and_dictation_are_not_implicitly_enabled(self):
        result = desktop.merge_shell({}, self.preferences, set())
        ids = {w["id"] for section in result["bar"]["layout"].values() for w in section}
        self.assertNotIn("illegalstudio.omarchy-lazyagent", ids)
        self.assertNotIn("superwhisper.panel", ids)
        self.assertNotIn("nahime.workspaces", ids)

    def test_existing_manifest_id_is_used_instead_of_folder_name(self):
        path = self.config / "omarchy/plugins/superwhisper-panel"
        path.mkdir(parents=True)
        (path / "manifest.json").write_text('{"id":"superwhisper.panel"}')
        shell = self.config / "omarchy/shell.json"
        shell.write_text('{"bar":{"layout":{"right":[{"id":"superwhisper.panel","keep":true}]}}}')
        with contextlib.redirect_stdout(io.StringIO()):
            desktop.configure(self.config, self.home, self.backups, True)
        widgets = json.loads(shell.read_text())["bar"]["layout"]["right"]
        self.assertIn({"id": "superwhisper.panel", "keep": True}, widgets)

    def test_legacy_bindings_migration_preserves_generated_dictation(self):
        legacy = json.loads((DESKTOP / "legacy-overrides.json").read_text())
        fragment = legacy["hypr/bindings.lua"][0]["text"]
        tail = '-- user integration\ndofile("/fixture/superwhisper.lua")\n'
        self.assertEqual(desktop.migrate(fragment + tail, legacy["hypr/bindings.lua"]), tail)
        with self.assertRaises(ValueError):
            desktop.migrate(fragment.replace('"Focus on left window"', '"Changed"'), legacy["hypr/bindings.lua"])

    def test_dry_run_never_writes_and_apply_is_repeatable(self):
        before = self.main.read_text()
        with contextlib.redirect_stdout(io.StringIO()):
            desktop.configure(self.config, self.home, self.backups, False)
        self.assertEqual(self.main.read_text(), before)
        self.assertFalse(self.backups.exists())
        with contextlib.redirect_stdout(io.StringIO()):
            desktop.configure(self.config, self.home, self.backups, True)
        text = self.main.read_text()
        self.assertLess(text.index(desktop.LOAD), text.index('require("default.hypr.toggles")'))
        self.assertIn("-- host-owned", text)
        self.assertEqual((self.backups / ".config/hypr/hyprland.lua").read_text(), before)
        self.assertEqual(self.backups.stat().st_mode & 0o777, 0o700)
        files = {p: p.stat().st_mtime_ns for p in self.config.rglob("*") if p.is_file()}
        with contextlib.redirect_stdout(io.StringIO()):
            desktop.configure(self.config, self.home, self.backups, True)
        self.assertEqual(files, {p: p.stat().st_mtime_ns for p in self.config.rglob("*") if p.is_file()})

    def test_focused_installer_links_modules_and_keeps_host_settings(self):
        monitor = self.config / "hypr/monitors.lua"
        monitor.write_text("-- private host setting\n")
        env = dict(os.environ, HOME=str(self.home), XDG_CONFIG_HOME=str(self.config),
                   XDG_STATE_HOME=str(self.home / ".local/state"),
                   HYPRLAND_INSTANCE_SIGNATURE="", DOTFILES_BACKUP_DIR=str(self.backups),
                   PYTHONDONTWRITEBYTECODE="1")
        command = [str(ROOT / "setup"), "--profile", "omarchy", "--only", "desktop", "--apply"]
        subprocess.run(command, env=env, capture_output=True, text=True, check=True)
        self.assertEqual(monitor.read_text(), "-- private host setting\n")
        self.assertEqual((self.config / "hypr/wide-layout.lua").resolve(), DESKTOP / "hypr/wide-layout.lua")
        self.assertEqual((self.config / "omarchy/plugins/nahime.workspaces").resolve(), DESKTOP / "plugins/nahime.workspaces")
        subprocess.run(command, env=env, capture_output=True, text=True, check=True)
        self.assertEqual(self.main.read_text().count(desktop.LOAD), 1)

    def test_jsonc_preserves_command_strings_and_unrelated_menu_items(self):
        text = '{"url":"https://example.test/a,}", /* note */ "items":[1, // note\n],}'
        self.assertEqual(desktop.jsonc(text), {"url": "https://example.test/a,}", "items": [1]})
        menu = self.config / "omarchy/extensions/omarchy-menu.jsonc"
        menu.parent.mkdir(parents=True)
        menu.write_text('// fixture\n{"setup.dictation":{"action":"keep-me"},}')
        with contextlib.redirect_stdout(io.StringIO()):
            desktop.configure(self.config, self.home, self.backups, True)
        self.assertEqual(json.loads(menu.read_text())["setup.dictation"], {"action": "keep-me"})

    def test_public_preferences_do_not_export_private_or_hardware_values(self):
        text = (DESKTOP / "shell-preferences.json").read_text()
        for key in ["birthYear", "lifeExpectancy", "microphone", "desktopOutput", "cities", "/home/nahime", "op://"]:
            self.assertNotIn(key, text)


if __name__ == "__main__":
    unittest.main()
