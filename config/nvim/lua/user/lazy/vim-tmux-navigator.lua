return {
  'christoomey/vim-tmux-navigator',
  cond = function()
    return vim.env.ZELLIJ == nil
  end,
}
