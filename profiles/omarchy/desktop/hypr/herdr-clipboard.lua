-- Extend Omarchy universal copy/paste to Herdr without changing window tags.
local function clipboard_shortcut(key)
  return function()
    local window = hl.get_active_window()
    local terminal = window and window.class == "herdr-app" or false

    for _, tag in ipairs(window and window.tags or {}) do
      if tag:gsub("%*$", "") == "terminal" then
        terminal = true
        break
      end
    end

    local mods = terminal and "CTRL SHIFT" or "CTRL"
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    -- Match Omarchy's split press/release to avoid stuck synthetic keys.
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.rebind("SUPER + C", "Universal copy (including Herdr)", clipboard_shortcut("C"))
o.rebind("SUPER + V", "Universal paste (including Herdr)", clipboard_shortcut("V"))
