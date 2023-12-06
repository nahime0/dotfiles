return {
  'glepnir/dashboard-nvim',
  opts = {
    theme = 'doom',
    config = {
      header = {
        '',
        '',
        '',
        -- ' ███▄    █  ▄▄▄       ██░ ██  ██▓ ███▄ ▄███▓▓█████ ',
        -- ' ██ ▀█   █ ▒████▄    ▓██░ ██▒▓██▒▓██▒▀█▀ ██▒▓█   ▀ ',
        -- '▓██  ▀█ ██▒▒██  ▀█▄  ▒██▀▀██░▒██▒▓██    ▓██░▒███   ',
        -- '▓██▒  ▐▌██▒░██▄▄▄▄██ ░▓█ ░██ ░██░▒██    ▒██ ▒▓█  ▄ ',
        -- '▒██░   ▓██░ ▓█   ▓██▒░▓█▒░██▓░██░▒██▒   ░██▒░▒████▒',
        -- '░ ▒░   ▒ ▒  ▒▒   ▓▒█░ ▒ ░░▒░▒░▓  ░ ▒░   ░  ░░░ ▒░ ░',
        -- '░ ░░   ░ ▒░  ▒   ▒▒ ░ ▒ ░▒░ ░ ▒ ░░  ░      ░ ░ ░  ░',
        -- '   ░   ░ ░   ░   ▒    ░  ░░ ░ ▒ ░░      ░      ░   ',
        -- '         ░       ░  ░ ░  ░  ░ ░         ░      ░  ░',
        '',
        '                  888      d8b                        ',
        '                  888      Y8P                        ',
        '                  888                                 ',
        '88888b.   8888b.  88888b.  888 88888b.d88b.   .d88b.  ',
        '888 "88b     "88b 888 "88b 888 888 "888 "88b d8P  Y8b ',
        '888  888 .d888888 888  888 888 888  888  888 88888888 ',
        '888  888 888  888 888  888 888 888  888  888 Y8b.     ',
        '888  888 "Y888888 888  888 888 888  888  888  "Y8888  ',
        '',
        'https://vuppi.dev',
        '',
        '',

      },
      center = {
        { icon = '  ', desc = 'New file', action = 'enew' },
        { icon = '  ', desc = 'Find file', key = 'Space + f', action = 'Telescope find_files' },
        { icon = '  ', desc = 'Recent files', key = 'Space + h', action = 'Telescope oldfiles' },
        { icon = '  ', desc = 'Find Word', key = 'Space + g', action = 'Telescope live_grep' },
      },
      footer = {
        '',
      }
    },
    hide = {
      statusline = false,
      tabline = false,
      winbar = false,
    }
  },
  init = function()
    vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#6272a4' })
    vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#f8f8f2' })
    vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#bd93f9' })
    vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#6272a4' })
    vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#6272a4' })
  end,
}
