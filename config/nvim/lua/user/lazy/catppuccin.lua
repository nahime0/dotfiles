return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    -- Common configuration
    flavour = 'latte',
    custom_highlights = function(colors)
      return {
        FloatBorder = {
          bg = colors.mantle,
          fg = colors.mantle
        },
        FloatermBorder = {
          bg = colors.mantle,
          fg = colors.text
        },
        Identifier = {
          -- fg = colors.flamingo
        }
      }
    end,
  },
  config = function (plugin, opts)
    require('catppuccin').setup(opts)

    vim.cmd('colorscheme catppuccin-mocha')
  end,
}
