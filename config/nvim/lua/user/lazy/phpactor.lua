return {
  'phpactor/phpactor',
  ft = 'php',
  config = function()
    vim.g.phpactorbinpath = vim.fn.exepath('phpactor.phar')
  end,
  keys = {
    { '<Leader>pm', ':PhpactorContextMenu<CR>' },
    { '<Leader>pn', ':PhpactorClassNew<CR>' },
  }
}
