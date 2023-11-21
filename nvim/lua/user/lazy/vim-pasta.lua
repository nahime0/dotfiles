return {
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disable_filetypes = { 'fugitive' }
  end,
}
