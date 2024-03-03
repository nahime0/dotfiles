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
      relative = 'editor',
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = "60",
      },
    },
    cmdline = {
      prompt = ' ',
    }
  },
}
