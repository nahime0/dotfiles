return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  dependencies = {
    { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        custom_calculation = function (node, language_tree)
          if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' then
            return '{{-- %s --}}'
          end
        end,
      },
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = 'all',
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
      disable = { "yaml" }
    },
    rainbow = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
      },
    },
  },
  config = function (_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- Support for custom filetypes
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {"src/parser.c"},
        branch = "main",
      },
      filetype = "blade"
    }
    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    })

    -- commentstrings
    require('ts_context_commentstring').setup({})
    vim.g.skip_ts_context_commentstring_module = true
  end,
}