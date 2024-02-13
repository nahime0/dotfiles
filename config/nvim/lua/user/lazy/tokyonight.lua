return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    -- Common configuration
    style = 'moon',

    -- Custom highlight
    on_highlights = function (highlight, color)
      local util = require('tokyonight.util')
      local prompt = "#2d3149"

      highlight.FloatermBorder = {
        bg = prompt,
        fg = prompt
      }
    end,
  },
  config = function (plugin, opts)
    require('tokyonight').setup(opts)

    vim.cmd('colorscheme tokyonight')
  end,
}
