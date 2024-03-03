return {
  'VonHeikemen/fine-cmdline.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  keys = {
    { ':', '<cmd>FineCmdline<CR>' },
  },
  opts = {
    popup = {
      border = 'rounded',
    },
    cmdline = {
      prompt = ' ',
    }
  },
}
