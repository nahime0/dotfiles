-- Automatic activation must not interrupt work in another window/workspace.
o.window({ tag = "terminal" }, { focus_on_activate = false })
o.window("^(brave-browser)$", { focus_on_activate = false })
o.window("^(org\\.gnome\\.Nautilus)$", { float = true })
