#!/usr/bin/env python3
"""Merge selected desktop preferences without exporting local/private state."""

import argparse
import copy
import json
import os
from pathlib import Path
import shutil
import tempfile


ROOT = Path(__file__).resolve().parent
LOAD = 'require("hypr.dotfiles.init")'


def jsonc(text):
    """Read comments/trailing commas without changing quoted command strings."""
    output = []
    index = 0
    quoted = False
    escaped = False
    while index < len(text):
        char = text[index]
        if quoted:
            output.append(char)
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                quoted = False
        elif char == '"':
            quoted = True
            output.append(char)
        elif text[index:index + 2] == "//":
            end = text.find("\n", index)
            index = len(text) if end == -1 else end
            output.append("\n")
            continue
        elif text[index:index + 2] == "/*":
            end = text.find("*/", index + 2)
            if end == -1:
                raise ValueError("Unterminated JSONC comment")
            index = end + 2
            output.append(" ")
            continue
        else:
            output.append(char)
        index += 1
    clean = "".join(output)
    output, quoted, escaped = [], False, False
    for index, char in enumerate(clean):
        if quoted:
            output.append(char)
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                quoted = False
        elif char == '"':
            quoted = True
            output.append(char)
        elif char != "," or not clean[index + 1:].lstrip().startswith(("}", "]")):
            output.append(char)
    return json.loads("".join(output))


def merge_shell(current, preferences, available):
    result = copy.deepcopy(current)
    bar = result.setdefault("bar", {})
    layout = bar.setdefault("layout", {})
    desired_layout = preferences["bar"]["layout"]
    existing = {w["id"]: w for widgets in layout.values() for w in widgets}
    managed = {w["id"] for widgets in desired_layout.values() for w in widgets}
    replaced = {"omarchy.workspaces", "omarchy.agents"}
    for section, widgets in desired_layout.items():
        merged = []
        for spec in widgets:
            ident = spec["id"]
            if spec.get("existingOnly") and ident not in existing:
                continue
            if not ident.startswith("omarchy.") and ident not in available:
                continue
            widget = copy.deepcopy(existing.get(ident, {"id": ident}))
            widget.update({k: v for k, v in spec.items() if k != "existingOnly"})
            merged.append(widget)
        # Preserve local widgets and their settings, including unknown plugins.
        merged.extend(w for w in layout.get(section, [])
                      if w["id"] not in managed | replaced)
        layout[section] = merged
    bar["background"] = preferences["bar"]["background"]
    result.setdefault("dock", {})["pinned"] = preferences["dock"]["pinned"]
    plugins = result.setdefault("plugins", [])
    if "illegalstudio.omarchy-cmdtab" in available and not any(
            p.get("id") == "illegalstudio.omarchy-cmdtab" for p in plugins):
        plugins.append({"id": "illegalstudio.omarchy-cmdtab"})
    return result


def migrate(text, fragments):
    for fragment in fragments:
        if fragment.get("marker") and fragment["marker"] in text:
            if fragment["text"] not in text:
                raise ValueError("Legacy bindings changed; review their migration first")
        text = text.replace(fragment["text"], "")
    return text


def backup(path, home, backup_root):
    relative = path.relative_to(home)
    target = backup_root / relative
    suffix = 0
    while target.exists() or target.is_symlink():
        suffix += 1
        target = backup_root / (str(relative) + f".{suffix}")
    backup_root.mkdir(parents=True, exist_ok=True, mode=0o700)
    backup_root.chmod(0o700)
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(path, target, follow_symlinks=False)


def write(path, text, home, backup_root):
    if path.exists() or path.is_symlink():
        backup(path, home, backup_root)
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, stage = tempfile.mkstemp(prefix=".dotfiles-", dir=path.parent)
    try:
        with os.fdopen(fd, "w") as stream:
            stream.write(text)
        os.chmod(stage, 0o644)
        os.replace(stage, path)
    finally:
        Path(stage).unlink(missing_ok=True)


def configure(config, home, backup_root, apply):
    legacy = json.loads((ROOT / "legacy-overrides.json").read_text())
    changes = {}
    for name, fragments in legacy.items():
        path = config / name
        old = path.read_text() if path.exists() else ""
        new = migrate(old, fragments)
        if name == "hypr/hyprland.lua":
            if not old:
                raise ValueError("Initialize the Omarchy Hyprland configuration first")
            if LOAD not in new:
                anchor = 'require("default.hypr.toggles")'
                if anchor not in new:
                    raise ValueError("Cannot find the workspace restore anchor in hyprland.lua")
                new = new.replace(anchor, LOAD + "\n\n" + anchor, 1)
        if new != old:
            changes[path] = new

    shell = config / "omarchy/shell.json"
    default = Path(os.environ.get("OMARCHY_PATH", "/usr/share/omarchy")) / "config/omarchy/shell.json"
    current = json.loads(shell.read_text()) if shell.exists() else (
        json.loads(default.read_text()) if default.exists() else {})
    preferences = json.loads((ROOT / "shell-preferences.json").read_text())
    plugins_dir = config / "omarchy/plugins"
    available = set()
    if plugins_dir.exists():
        for path in plugins_dir.iterdir():
            manifest = path / "manifest.json"
            if manifest.is_file():
                available.add(json.loads(manifest.read_text())["id"])
    merged = merge_shell(current, preferences, available)
    if merged != current:
        changes[shell] = json.dumps(merged, indent=2) + "\n"
    menu = config / "omarchy/extensions/omarchy-menu.jsonc"
    current_menu = jsonc(menu.read_text()) if menu.exists() else {}
    merged_menu = {**current_menu, **json.loads((ROOT / "menu-preferences.json").read_text())}
    if merged_menu != current_menu:
        changes[menu] = json.dumps(merged_menu, indent=2) + "\n"
    # Validate every planned destination before making any changes.
    for path in changes:
        path.relative_to(home)
    for path, text in changes.items():
        print(("write: " if apply else "+ merge: ") + str(path))
        if apply:
            write(path, text, home, backup_root)
    if not changes:
        print("unchanged: desktop configuration")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    home = Path.home()
    config = Path(os.environ.get("XDG_CONFIG_HOME", home / ".config"))
    backups = Path(os.environ["DOTFILES_BACKUP_DIR"])
    try:
        configure(config, home, backups, args.apply)
    except (ValueError, OSError, KeyError) as error:
        parser.exit(1, f"Desktop configuration failed: {error}\n")
