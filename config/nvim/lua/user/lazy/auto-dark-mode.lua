local function set_dark_mode()
  if vim.o.background == 'dark' and vim.g.colors_name == 'nord' then
    return
  end

  vim.api.nvim_set_option_value('background', 'dark', {})
  vim.cmd.colorscheme('nord')
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#4C566A', bg = '#2E3440' })
  vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = '#81A1C1', bg = '#2E3440' })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#242933', bg = '#2E3440' })
end

local function set_light_mode()
  if vim.o.background == 'light' and vim.g.colors_name == 'nord-light' then
    return
  end

  vim.api.nvim_set_option_value('background', 'light', {})
  vim.cmd.colorscheme('nord-light')
  vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = '#4B6C8C', bg = '#D8DEE9' })
end

return {
  'f-person/auto-dark-mode.nvim',
  lazy = false,
  opts = {
    update_interval = 1000,
    set_dark_mode = set_dark_mode,
    set_light_mode = set_light_mode,
  },
}
