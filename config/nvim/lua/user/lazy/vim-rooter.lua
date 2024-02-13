return {
  'airblade/vim-rooter',
  init = function()
    vim.g.rooter_manual_only = true -- Only run when manually called or when vim is opened for the first time
    vim.g.rooter_patterns = {'.git', 'composer.json'} -- The files to search for to establish the root of the project
  end,
  config = function()
    vim.cmd('Rooter')
  end,
}
