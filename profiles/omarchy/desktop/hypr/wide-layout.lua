-- Third workspace layout, "wide": the scrolling layout with columns at 95%
-- of the screen. Hyprland has a single global scrolling.column_width, so the
-- width is a per-workspace window rule plus a resize of columns already open.
-- Called from ~/.config/hypr/workspace-layout-cycle and from the saved
-- workspace layout files under ~/.local/state/omarchy/workspace-layouts/.

local WIDE_COLUMN_WIDTH = 0.95

wide_workspace_rules = {}
wide_pending_resize = {}

local function wide_resize_active(all_columns)
  local message = all_columns and ("colresize all " .. WIDE_COLUMN_WIDTH) or ("colresize " .. WIDE_COLUMN_WIDTH)
  hl.dispatch(hl.dsp.layout(message))
end

function omarchy_workspace_set_wide(workspace_id, enabled, opts)
  opts = opts or {}
  local id = tostring(workspace_id)
  local rule = wide_workspace_rules[id]

  if enabled then
    if not rule then
      rule = hl.window_rule({
        name = "workspace-wide-" .. id,
        match = { workspace = id },
        scrolling_width = WIDE_COLUMN_WIDTH,
      })
      wide_workspace_rules[id] = rule
    end
    rule:set_enabled(true)
    if opts.pending then
      wide_pending_resize[id] = true
    end
    if opts.resize_now then
      pcall(wide_resize_active, true)
      wide_pending_resize[id] = nil
    end
  elseif rule then
    rule:set_enabled(false)
    wide_pending_resize[id] = nil
  end
end

local function apply_pending_wide(workspace)
  if not workspace then
    return
  end
  local id = tostring(workspace.id)
  if not wide_pending_resize[id] or workspace.tiled_layout ~= "scrolling" then
    return
  end
  wide_pending_resize[id] = nil
  pcall(wide_resize_active, true)
end

hl.on("workspace.active", function(workspace)
  apply_pending_wide(workspace)
end)

hl.on("config.reloaded", function()
  apply_pending_wide(hl.get_active_workspace())
end)

hl.on("hyprland.start", function()
  apply_pending_wide(hl.get_active_workspace())
end)

-- scrolling_width is applied only when a window opens. A window moved onto a
-- wide workspace keeps the column width it already had unless it is focused.
hl.on("window.move_to_workspace", function(window, workspace)
  if not window or not workspace or not window.active then
    return
  end
  local rule = wide_workspace_rules[tostring(workspace.id)]
  if not rule or not rule:is_enabled() then
    return
  end
  pcall(wide_resize_active, false)
end)
