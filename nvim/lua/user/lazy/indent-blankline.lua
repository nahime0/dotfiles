return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl', -- specify the module name to be used in the require(X).setup()
  opts = {
    scope = {
      show_start = false,
    },
    exclude = {
        filetypes = {
            'help',
            'terminal',
            'dashboard',
            'packer',
            'lspinfo',
            'TelescopePrompt',
            'TelescopeResults',
        },
        buftypes = {
            'terminal'
        }
    },
  }
}
