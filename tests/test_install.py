"""Installer regression checks; all writes stay inside temporary homes."""

import os
from pathlib import Path
import socket
import stat
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
PRIVATE_AVAILABLE = (ROOT / "dotfiles-private/setup").is_file()


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles install ", dir="/tmp")
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name) / "home with spaces"
        self.home.mkdir()
        self.backups = self.home / "backups"
        self.env = dict(os.environ, HOME=str(self.home),
                        XDG_CONFIG_HOME=str(self.home / ".config"),
                        XDG_STATE_HOME=str(self.home / ".local/state"),
                        DOTFILES_ROOT=str(ROOT), DOTFILES_APPLY="true",
                        DOTFILES_BACKUP_DIR=str(self.backups))

    def public(self, script, apply=True, check=True):
        env = dict(self.env, DOTFILES_APPLY=str(apply).lower())
        return subprocess.run(
            ["/bin/bash", "-c", 'set -euo pipefail; source "$1"; ' + script,
             "test", str(ROOT / "lib/install.sh")],
            env=env, capture_output=True, text=True, check=check)

    def private(self, apply=True):
        args = ["/bin/bash", str(ROOT / "dotfiles-private/setup"),
                "--profile", "macos"]
        if apply:
            args.append("--apply")
        return subprocess.run(args, env=self.env, capture_output=True,
                              text=True, check=True)

    def test_backup_copies_never_overwrite_earlier_contents(self):
        target = self.home / "config"
        target.write_text("first")
        self.public('backup_copy_path "$HOME/config"')
        target.write_text("second")
        self.public('backup_path "$HOME/config"')
        self.assertEqual((self.backups / "config").read_text(), "first")
        self.assertEqual((self.backups / "config.1").read_text(), "second")
        self.assertFalse(target.exists())

    def test_backups_are_private_even_with_permissive_umask(self):
        (self.home / "credentials").write_text("fixture only")
        self.public('umask 022; backup_path "$HOME/credentials"')
        self.assertEqual(stat.S_IMODE(self.backups.stat().st_mode), 0o700)

    def test_broken_symlink_is_backed_up_without_following_it(self):
        target = self.home / "config"
        target.symlink_to("missing-original")
        self.public('link_file "$DOTFILES_ROOT/config/git/gitconfig" "$HOME/config"')
        self.assertEqual(os.readlink(self.backups / "config"), "missing-original")
        self.assertEqual(target.resolve(), ROOT / "config/git/gitconfig")

    def test_replacing_directory_preserves_its_contents(self):
        target = self.home / "config"
        target.mkdir()
        (target / "local").write_text("keep me")
        self.public('link_file "$DOTFILES_ROOT/config/nvim" "$HOME/config"')
        self.assertEqual((self.backups / "config/local").read_text(), "keep me")
        self.assertEqual(target.resolve(), ROOT / "config/nvim")

    def test_reapply_does_not_replace_correct_links_or_copy_files(self):
        script = ('link_file "$DOTFILES_ROOT/config/git/gitconfig" "$HOME/link"; '
                  'copy_file "$DOTFILES_ROOT/config/git/gitconfig" "$HOME/copy"')
        self.public(script)
        before = [(self.home / name).lstat().st_ino for name in ("link", "copy")]
        self.public(script)
        self.assertEqual(before, [(self.home / name).lstat().st_ino
                                  for name in ("link", "copy")])
        self.assertFalse(self.backups.exists())

    def test_source_line_preserves_local_integrations_and_is_idempotent(self):
        target = self.home / ".zshrc"
        target.write_text("# local Herd configuration\n")
        script = 'ensure_source_line "$HOME/.zshrc" \'source "dotfiles"\''
        self.public(script)
        self.public(script)
        self.assertEqual(target.read_text().count('source "dotfiles"'), 1)
        self.assertEqual((self.backups / ".zshrc").read_text(),
                         "# local Herd configuration\n")

    def test_dry_run_does_not_write_or_create_backups(self):
        target = self.home / "config"
        target.write_text("original")
        self.public('link_file "$DOTFILES_ROOT/config/nvim" "$HOME/config"; '
                    'ensure_source_line "$HOME/.zshrc" "source dotfiles"', apply=False)
        self.assertEqual(target.read_text(), "original")
        self.assertFalse((self.home / ".zshrc").exists())
        self.assertFalse(self.backups.exists())

    def test_backup_rejects_paths_outside_home(self):
        outside = Path(self.temp.name) / "outside"
        outside.write_text("untouched")
        self.env["OUTSIDE"] = str(outside)
        result = self.public('backup_path "$OUTSIDE"', check=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(outside.read_text(), "untouched")

    def test_public_dry_run_does_not_change_home(self):
        subprocess.run(["/bin/bash", str(ROOT / "setup"), "--profile", "macos"],
                       env=self.env, capture_output=True, text=True, check=True)
        self.assertEqual(list(self.home.iterdir()), [])

    def test_incompatible_profile_is_rejected_before_writes(self):
        profile = "omarchy" if os.uname().sysname == "Darwin" else "macos"
        result = subprocess.run(
            ["/bin/bash", str(ROOT / "setup"), "--profile", profile, "--apply"],
            env=self.env, capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(list(self.home.iterdir()), [])

    @unittest.skipUnless(PRIVATE_AVAILABLE and os.uname().sysname == "Darwin",
                         "requires macOS and the optional private checkout")
    def test_private_install_preserves_local_ssh_keys_and_reapplies_cleanly(self):
        ssh = self.home / ".ssh"
        ssh.mkdir(mode=0o755)
        (ssh / "id_rsa").write_text("fixture key, not a real key")
        (ssh / "config").write_text("# original local SSH config\n")
        self.private()
        self.assertEqual((ssh / "id_rsa").read_text(), "fixture key, not a real key")
        self.assertEqual(stat.S_IMODE(ssh.stat().st_mode), 0o700)
        self.assertEqual((self.backups / ".ssh/config").read_text(),
                         "# original local SSH config\n")
        agent = self.home / ".1password/agent.sock"
        self.assertEqual(os.readlink(agent), str(self.home /
                         "Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"))
        before = sorted(str(p) for p in self.backups.rglob("*"))
        self.private()
        self.assertEqual(before, sorted(str(p) for p in self.backups.rglob("*")))

    @unittest.skipUnless(PRIVATE_AVAILABLE and os.uname().sysname == "Darwin",
                         "requires macOS and the optional private checkout")
    def test_private_migrates_ssh_directory_symlink_without_losing_keys(self):
        legacy = self.home / "legacy ssh"
        legacy.mkdir()
        (legacy / "id_rsa").write_text("fixture key")
        (legacy / "config").write_text("# legacy config\n")
        (self.home / ".ssh").symlink_to(legacy, target_is_directory=True)
        # Unix sockets cannot be copied as files and must be skipped.
        sock = socket.socket(socket.AF_UNIX)
        self.addCleanup(sock.close)
        sock.bind(str(legacy / "agent.sock"))
        self.private()
        self.assertFalse((self.home / ".ssh").is_symlink())
        self.assertEqual((self.home / ".ssh/id_rsa").read_text(), "fixture key")
        self.assertEqual((legacy / "config").read_text(), "# legacy config\n")
        self.assertTrue((self.backups / ".ssh").is_symlink())
        self.assertEqual(stat.S_IMODE(self.backups.stat().st_mode), 0o700)

    @unittest.skipUnless(PRIVATE_AVAILABLE, "optional private checkout is absent")
    def test_private_dry_run_leaves_ssh_directory_symlink_untouched(self):
        legacy = self.home / "legacy ssh"
        legacy.mkdir()
        (legacy / "config").write_text("# original\n")
        (self.home / ".ssh").symlink_to(legacy, target_is_directory=True)
        self.private(apply=False)
        self.assertTrue((self.home / ".ssh").is_symlink())
        self.assertEqual((legacy / "config").read_text(), "# original\n")
        self.assertFalse(self.backups.exists())
        self.assertFalse((self.home / ".gitidentity").exists())


if __name__ == "__main__":
    unittest.main()
