return {
  'arcticicestudio/nord-vim',
  lazy = false,
  priority = 1000,
  opts = {
    -- Common configuration
  },
  config = function (plugin, opts)
    -- require('nord').setup(opts)

    vim.cmd('colorscheme nord')
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#4C566A', bg = '#2E3440' })
    vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = '#81A1C1', bg = '#2E3440' })
  end,
}
