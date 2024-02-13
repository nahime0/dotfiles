return {
  'voldikss/vim-floaterm',
  keys = {
    { '<C-t>', '<cmd>FloatermToggle<cr>' },
    { '<C-t>', '<C-\\><C-n><cmd>FloatermToggle<cr>', mode = 't' },
  },
  cmd = { 'FloatermToggle' },
  init = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
  end,
}
