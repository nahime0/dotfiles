return {
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    -- Common configuration

    -- Custon highlight
    -- For a list of default colors:
    -- https://github.com/olimorris/onedarkpro.nvim/blob/main/lua/onedarkpro/themes/onedark_vivid.lua
    highlights = {
      FloatBorder = {
        bg = "${bg}",
        fg = "${purple}"
      },
      FloatermBorder = {
        bg = "${bg}",
        fg = "${blue}"
      },
      Identifier = {
        fg = "${white}"
      }
    }
  },
  config = function (plugin, opts)
    require('onedarkpro').setup(opts)

    vim.cmd('colorscheme onedark_vivid')
  end,
}
