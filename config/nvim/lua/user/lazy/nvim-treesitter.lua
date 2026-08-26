local languages = {
  'bash', 'blade', 'c', 'cpp', 'css', 'dockerfile', 'go', 'html',
  'javascript', 'json', 'lua', 'markdown', 'php', 'python', 'rust',
  'sql', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        custom_calculation = function(_, language_tree)
          if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' then
            return '{{-- %s --}}'
          end
        end,
      },
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
  },
  config = function()
    local function register_blade()
      require('nvim-treesitter.parsers').blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
          queries = 'queries',
        },
      }
    end

    register_blade()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      callback = register_blade,
    })

    require('nvim-treesitter').setup()

    vim.filetype.add({
      pattern = { ['.*%.blade%.php'] = 'blade' },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        if vim.bo[args.buf].filetype ~= 'yaml' then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require('nvim-treesitter-textobjects').setup({
      select = { lookahead = true },
    })

    local select = require('nvim-treesitter-textobjects.select').select_textobject
    vim.keymap.set({ 'x', 'o' }, 'if', function()
      select('@function.inner', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'af', function()
      select('@function.outer', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'ia', function()
      select('@parameter.inner', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'aa', function()
      select('@parameter.outer', 'textobjects')
    end)

    require('ts_context_commentstring').setup({})
    vim.g.skip_ts_context_commentstring_module = true
    vim.api.nvim_set_hl(0, '@variable.php', { link = 'Identifier' })
  end,
}
