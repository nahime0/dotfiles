-- Forward shortcuts to fullscreen RustDesk, keeping Super+1 as a local exit.
local SUBMAP = "rustdesk-fullscreen"
local pending = false

local function is_fullscreen_session(window)
  return window
    and window.mapped
    and not window.hidden
    and (window.class or ""):lower() == "rustdesk"
    and (window.title or ""):match(" %- Remote Desktop %- RustDesk$") ~= nil
    and (window.fullscreen == 2 or window.fullscreen == 3)
end

local function sync_shortcuts()
  local submap = hl.get_current_submap()
  if is_fullscreen_session(hl.get_active_window()) then
    -- Let modal switchers finish before taking over the default submap.
    if submap == "" then
      hl.dispatch(hl.dsp.submap(SUBMAP))
    end
  elseif submap == SUBMAP then
    hl.dispatch(hl.dsp.submap("reset"))
  end
end

local function schedule_sync()
  if pending then
    return
  end
  pending = true
  -- Focus and fullscreen events may fire before their transitions finish.
  hl.timer(function()
    pending = false
    sync_shortcuts()
  end, { timeout = 1, type = "oneshot" })
end

hl.define_submap(SUBMAP, function()
  hl.bind("SUPER + 1", function()
    hl.dispatch(hl.dsp.submap("reset"))
    hl.dispatch(hl.dsp.focus({ workspace = "1" }))
  end, {
    description = "Leave fullscreen RustDesk for workspace 1",
    dont_inhibit = true,
    allow_input_capture = true,
  })
end)

for _, event in ipairs({
  "window.active",
  "window.fullscreen",
  "window.open",
  "window.close",
  "window.title",
  "window.class",
  "window.move_to_workspace",
  "workspace.active",
  "keybinds.submap",
  "config.reloaded",
}) do
  hl.on(event, schedule_sync)
end

schedule_sync()
