function split(str, sep)
    local sep, res = sep or '%s', {' '}
    string.gsub(str, '[^'..sep..']+', function(x) res[#res+1] = x end)
    return res
end

local handle = io.popen("sort -R ~/.quotes.txt | head -1 | tr -d '\n'")
local quote = handle:read("*a")
quoteText = split(quote, "|")
handle:close()

local function set_dashboard_highlights()
  local colors

  if vim.o.background == 'light' then
    colors = {
      DashboardHeader = '#4B6C8C',
      DashboardDesc = '#3B4252',
      DashboardIcon = '#865B7F',
      DashboardKey = '#3B5E85',
      DashboardShortCut = '#3B5E85',
      DashboardFooter = '#4C566A',
    }
  else
    colors = {
      DashboardHeader = '#81A1C1',
      DashboardDesc = '#D8DEE9',
      DashboardIcon = '#B48EAD',
      DashboardKey = '#81A1C1',
      DashboardShortCut = '#81A1C1',
      DashboardFooter = '#88C0D0',
    }
  end

  for group, foreground in pairs(colors) do
    vim.api.nvim_set_hl(0, group, { fg = foreground })
  end
end

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
        -- '',
        -- '                  888      d8b                        ',
        -- '                  888      Y8P                        ',
        -- '                  888                                 ',
        -- '88888b.   8888b.  88888b.  888 88888b.d88b.   .d88b.  ',
        -- '888 "88b     "88b 888 "88b 888 888 "888 "88b d8P  Y8b ',
        -- '888  888 .d888888 888  888 888 888  888  888 88888888 ',
        -- '888  888 888  888 888  888 888 888  888  888 Y8b.     ',
        -- '888  888 "Y888888 888  888 888 888  888  888  "Y8888  ',
        '',
        '███▄▄▄▄      ▄████████    ▄█    █▄     ▄█    ▄▄▄▄███▄▄▄▄      ▄████████ ',
        '███▀▀▀██▄   ███    ███   ███    ███   ███  ▄██▀▀▀███▀▀▀██▄   ███    ███ ',
        '███   ███   ███    ███   ███    ███   ███▌ ███   ███   ███   ███    █▀  ',
        '███   ███   ███    ███  ▄███▄▄▄▄███▄▄ ███▌ ███   ███   ███  ▄███▄▄▄     ',
        '███   ███ ▀███████████ ▀▀███▀▀▀▀███▀  ███▌ ███   ███   ███ ▀▀███▀▀▀     ',
        '███   ███   ███    ███   ███    ███   ███  ███   ███   ███   ███    █▄  ',
        '███   ███   ███    ███   ███    ███   ███  ███   ███   ███   ███    ███ ',
        ' ▀█   █▀    ███    █▀    ███    █▀    █▀    ▀█   ███   █▀    ██████████ ',
        '',
        'https://nahi.me',
        '',
        '',

      },
      center = {
        { icon = '  ', desc = 'New file', action = 'enew' },
        { icon = '  ', desc = 'Find file', key = 'Space + f', action = 'Telescope find_files' },
        { icon = '  ', desc = 'Recent files', key = 'Space + h', action = 'Telescope oldfiles' },
        { icon = '  ', desc = 'Find Word', key = 'Space + g', action = 'Telescope live_grep' },
      },
      footer = quoteText
    },
    hide = {
      statusline = false,
      tabline = false,
      winbar = false,
    }
  },
  init = function()
    set_dashboard_highlights()

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('user_dashboard_colors', { clear = true }),
      callback = set_dashboard_highlights,
    })
  end,
}
