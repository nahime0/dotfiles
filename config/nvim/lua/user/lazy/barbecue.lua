return {
  'utilyre/barbecue.nvim',
  name = "barbecue",
  event = 'BufRead',
  version = "*",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      init = function()
        -- Suppress navic annoying navic errors (cannot attach to intelephense)
         vim.g.navic_silence = true
      end,
    },
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    theme = 'tokyonight',
  },
}
