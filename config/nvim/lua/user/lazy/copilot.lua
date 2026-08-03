return {
  'github/copilot.vim',
  config = function()
    -- Accept the current suggestion with Alt+Enter. `replace_keycodes` must stay
    -- off: copilot#Accept() already returns the terminal codes to insert.
    vim.keymap.set('i', '<M-CR>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
      desc = 'Accept Copilot suggestion',
    })
  end,
}
