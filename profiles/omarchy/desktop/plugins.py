#!/usr/bin/env python3
"""Install the selected Omarchy plugins without updating existing checkouts."""

import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
from configure import backup

ROOT = Path(__file__).resolve().parent


def install(apply):
    # Omarchy's plugin CLI currently uses ~/.config, even with another XDG root.
    config = Path(os.environ.get("XDG_CONFIG_HOME", Path.home() / ".config"))
    if config != Path.home() / ".config":
        raise ValueError("The Omarchy plugin CLI requires the default ~/.config location")
    recipes = json.loads((ROOT / "plugins.json").read_text())
    if apply and not shutil.which("omarchy"):
        raise ValueError("The omarchy command is required")
    backed_up = False

    def run(command):
        nonlocal backed_up
        shell = config / "omarchy/shell.json"
        if not backed_up and shell.exists():
            backup(shell, Path.home(), Path(os.environ["DOTFILES_BACKUP_DIR"]))
            backed_up = True
        subprocess.run(command, check=True)

    for recipe in recipes:
        ident = recipe["id"]
        target = config / "omarchy/plugins" / ident
        if target.exists():
            manifest = json.loads((target / "manifest.json").read_text())
            if manifest.get("id") != ident:
                raise ValueError(f"Unexpected plugin id in {target}")
            print(f"unchanged: installed {ident}", flush=True)
        else:
            command = ["omarchy", "plugin", "add", recipe["url"], "--yes"]
            print("+ " + " ".join(command), flush=True)
            if apply:
                run(command)
                manifest = json.loads((target / "manifest.json").read_text())
                if manifest.get("id") != ident:
                    raise ValueError(f"Installed plugin does not match {ident}")
        command = ["omarchy", "plugin", "enable", ident]
        if recipe.get("section"):
            command += ["--section", recipe["section"]]
        if apply:
            state = json.loads(subprocess.check_output(["omarchy", "plugin", "list", "--json"]))
            if any(p["id"] == ident and p.get("enabled") for p in state):
                print(f"unchanged: enabled {ident}", flush=True)
                continue
        print("+ " + " ".join(command), flush=True)
        if apply:
            run(command)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    try:
        install(args.apply)
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"Plugin installation failed: {error}\n")
