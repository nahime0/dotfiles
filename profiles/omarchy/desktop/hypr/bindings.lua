-- Personal bindings, loaded after Omarchy defaults.
for _, key in ipairs({ "H", "J", "K", "L" }) do
  hl.unbind("SUPER + " .. key)
end
for _, key in ipairs({ "LEFT", "RIGHT", "UP", "DOWN" }) do
  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)
end
for key, direction in pairs({ H = "l", J = "d", K = "u", L = "r" }) do
  o.rebind("SUPER + " .. key, "Focus window " .. direction, hl.dsp.focus({ direction = direction }))
  o.rebind("SUPER + SHIFT + " .. key, "Swap window " .. direction, hl.dsp.window.swap({ direction = direction }))
end
o.rebind("SUPER + LEFT", "Toggle window split", hl.dsp.layout("togglesplit"))
o.rebind("SUPER + DOWN", "Keybindings", "omarchy-menu-keybindings")
o.rebind("SUPER + RIGHT", "Cycle workspace layout (including Wide)",
  (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/hypr/workspace-layout-cycle")
o.rebind("SUPER + UP", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
hl.unbind("SUPER + ALT + S")
o.rebind("SUPER + SHIFT + S", "Move window to scratchpad",
  hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

local cmdtab = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config")
  .. "/omarchy/plugins/illegalstudio.omarchy-cmdtab/hyprland.lua"
local file = io.open(cmdtab, "r")
if file then
  file:close()
  dofile(cmdtab)("SUPER")
end
