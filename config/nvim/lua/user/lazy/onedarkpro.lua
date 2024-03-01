return {
  'olimorris/onedarkpro.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    -- Common configuration

    -- Custon highlight
    highlights = {
      FloatermBorder = {
        bg = "#292c34",
        fg = "#ABABAB"
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
