local uv = vim.uv or vim.loop
local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
local poll = uv.new_fs_poll()
local pending = false
local last_reload = 0

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyReload",
  callback = function()
    last_reload = uv.hrtime()
  end,
})

local function changed(prev, current)
  if not prev or not current then
    return true
  end

  return prev.ino ~= current.ino
    or prev.size ~= current.size
    or prev.mtime.sec ~= current.mtime.sec
    or prev.mtime.nsec ~= current.mtime.nsec
end

poll:start(theme_file, 500, function(err, prev, current)
  if err or pending or not changed(prev, current) then
    return
  end

  pending = true
  local changed_at = uv.hrtime()
  vim.defer_fn(function()
    pending = false
    if last_reload < changed_at then
      vim.api.nvim_exec_autocmds("User", { pattern = "LazyReload" })
    end
  end, 250)
end)

vim.api.nvim_create_autocmd("VimLeavePre", {
  once = true,
  callback = function()
    if not poll:is_closing() then
      poll:stop()
      poll:close()
    end
  end,
})

return poll
