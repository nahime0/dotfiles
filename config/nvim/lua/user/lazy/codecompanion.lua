return {
  'olimorris/codecompanion.nvim',
  version = '^19.0.0',
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
  },
  keys = {
    {
      '<leader>aa',
      '<cmd>CodeCompanionActions<cr>',
      mode = { 'n', 'v' },
      desc = 'CodeCompanion actions',
    },
    {
      '<leader>ac',
      '<cmd>CodeCompanionChat Toggle<cr>',
      mode = { 'n', 'v' },
      desc = 'Toggle CodeCompanion chat',
    },
    {
      '<leader>as',
      '<cmd>CodeCompanionChat Add<cr>',
      mode = 'v',
      desc = 'Add selection to CodeCompanion chat',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    interactions = {
      chat = {
        adapter = 'cursor_cli',
      },
    },
  },
}
