return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'nvimtools/none-ls.nvim',
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    -- Setup Mason to automatically install LSP servers
    require('mason').setup({
      ui = {
        height = 0.8,
      },
    })
    require('mason-lspconfig').setup({
      ensure_installed = {
        'intelephense',
        'phpactor',
        'html',
        'vue_ls',
        'tailwindcss',
        'elixirls',
        'gopls',
        'jsonls',
      },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Global LSP config with capabilities
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Server-specific configurations
    vim.lsp.config('intelephense', {
      capabilities = capabilities,
      commands = {
        IntelephenseIndex = {
          function()
            vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
          end,
        },
      },
    })

    vim.lsp.config('jsonls', {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    })

    -- LspAttach autocmd for on_attach logic
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        -- Disable formatting for specific servers
        if client.name == 'intelephense' or client.name == 'vue_ls' then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Disable most capabilities for phpactor (use intelephense instead)
        if client.name == 'phpactor' then
          client.server_capabilities.completionProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.implementationProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.renameProvider = false
          client.server_capabilities.selectionRangeProvider = false
          client.server_capabilities.signatureHelpProvider = false
          client.server_capabilities.typeDefinitionProvider = false
          client.server_capabilities.workspaceSymbolProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.documentHighlightProvider = false
          client.server_capabilities.documentSymbolProvider = false
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end,
    })

    -- Enable all LSP servers
    vim.lsp.enable({
      'intelephense',
      'phpactor',
      'html',
      'vue_ls',
      'tailwindcss',
      'elixirls',
      'gopls',
      'jsonls',
    })

    -- null-ls
    local null_ls = require('null-ls')
    local eslint_d_diagnostic = require('none-ls.diagnostics.eslint_d')
    local eslint_d_formatting = require('none-ls.formatting.eslint_d')
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      temp_dir = '/tmp',
      sources = {
        -- eslint_d
        eslint_d_diagnostic.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
          end,
        }),
        eslint_d_formatting.with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
          end,
        }),

        -- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
        null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
        null_ls.builtins.formatting.pint.with({
          condition = function(utils)
            return utils.root_has_file({ 'vendor/bin/pint' })
          end,
        }),
        null_ls.builtins.formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
          end,
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
            end,
          })
        end
      end,
    })

    require('mason-null-ls').setup({ automatic_installation = true })

    -- Keymaps
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
    vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
    vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Commands
    vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        source = true,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        }
      }
    })

  end,
}
