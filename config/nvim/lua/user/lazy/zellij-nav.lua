return {
  'swaits/zellij-nav.nvim',
  cond = function()
    return vim.env.ZELLIJ ~= nil
  end,
  event = 'VeryLazy',
  keys = {
    {
      '<C-h>',
      '<cmd>ZellijNavigateLeftTab<cr>',
      mode = { 'n', 't' },
      desc = 'Navigate left through Neovim, Zellij panes, and tabs',
    },
    {
      '<C-j>',
      '<cmd>ZellijNavigateDown<cr>',
      mode = { 'n', 't' },
      desc = 'Navigate down through Neovim and Zellij panes',
    },
    {
      '<C-k>',
      '<cmd>ZellijNavigateUp<cr>',
      mode = { 'n', 't' },
      desc = 'Navigate up through Neovim and Zellij panes',
    },
    {
      '<C-l>',
      '<cmd>ZellijNavigateRightTab<cr>',
      mode = { 'n', 't' },
      desc = 'Navigate right through Neovim, Zellij panes, and tabs',
    },
  },
  opts = {},
}
