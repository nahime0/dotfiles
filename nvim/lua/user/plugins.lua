-- Ensure that packer is installed
-- https://github.com/wbthomason/packer.nvim#bootstrapping

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use packer init instead of startup
require('packer').reset()
require('packer').init({
    compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'solid' })
        end
    },
})

-- require the packer use function
local use = require('packer').use

-- Include plugins
use('wbthomason/packer.nvim')

-- Theme
use({
    'folke/tokyonight.nvim',
    config = function()
        vim.g.tokyonight_style = 'night'
--        vim.g.tokyonight_italic_functions = true
--        vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }
--        vim.g.tokyonight_dark_sidebar = true
--        vim.g.tokyonight_dark_float = true
--        vim.g.tokyonight_colors = { hint = 'orange', error = '#ff0000' }
        vim.cmd('colorscheme tokyonight')
        -- Set the border for floating windows as the same as the background color
        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
            bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        })
    end,
})

-- Include vim commentary
-- Comment stuff out (use gcc to comment out a line)
use('tpope/vim-commentary')

-- Include vim surround
-- Easily add, change and delete surroundings in pairs (e.g. cs"' to change surrounding " from double quotes to single quotes)
use('tpope/vim-surround')

-- vim enunch - command like :Rename and :SudoWrite
use('tpope/vim-eunuch')

-- Map other pair of brackets
use('tpope/vim-unimpaired')

-- Use editorconfig to set up the editor indentations
use('tpope/vim-sleuth')

-- Use vim repeat to allow plugins to repeat actions
use('tpope/vim-repeat')

-- Add more languages support (leave or remove?)
use('sheerun/vim-polyglot')

-- Integration with tmux
use('christoomey/vim-tmux-navigator')

-- Return to the last location on a file when opening it
use('farmergreg/vim-lastplace')

-- Enable * searching also for visual selection
use('nelstrom/vim-visual-star-search')

-- Automatically create folders when saving a file
use('jessarcher/vim-heritage')

-- Add support for vim objects for HTML attributes (leave or remove?)
use({
    'whatyouhide/vim-textobj-xmlattr',
    requires = { 'kana/vim-textobj-user' },
})

-- Set the working directory to the project root
use ({
    'airblade/vim-rooter',
    -- Only run when manually called or when vim is opened for the first time
    setup = function()
        vim.g.rooter_manual_only = true
    end,
    config = function()
        vim.cmd('Rooter')
    end,
})

-- Use auto pairs to automatically close brackets
use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})

-- Use neoscroll to scroll smoothly
use({
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup()
    end,
})

--Use bufdelete to delete buffers but keep the split open
use({
    'famiu/bufdelete.nvim',
    config = function()
        vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
    end,
})

-- Use splitjoins to split and join arrays (and others) in multiple lines (e.g. gS to split, gJ to join)
use({
    'AndrewRadev/splitjoin.vim',
    config = function()
        vim.g.splitjoin_html_atttributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
    end,
})

-- Use vim pasta to automatically fix indentation when pasting
use({
    'sickill/vim-pasta',
    config = function()
        vim.g.pasta_disable_filetypes = { 'fugitive' }
    end,
})

-- Fuzzy finder
use({
    'nvim-telescope/telescope.nvim',
    after = 'tokyonight.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
        require('user/plugins/telescope')
    end,
})

-- Side tree
use ({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            's1n7ax/nvim-window-picker',
            opts = {
                filter_rules = {
                    autoselect_one = true,
                    include_current_win = false,
                    bo = {
                        filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                        buftype = { 'terminal', "quickfix" },
                    },
                },
                highlights = {
                    statusline = {
                        focused = {
                            bg = '#9d7cd8',
                        },
                        unfocused = {
                            bg = '#9d7cd8',
                        },
                    },
                },
            },
        },
    },
    config = function()
        require('user/plugins/neo-tree')
    end,
})

-- Include lualine
use({
    'nvim-lualine/lualine.nvim',
    requires = {
        'arkav/lualine-lsp-progress',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('user/plugins/lualine')
    end,
})

-- Include bufferline
use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'tokyonight.nvim',
    config = function()
        require('user/plugins/bufferline')
    end,
})

-- Indent blank lines
use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('user/plugins/indent-blankline')
    end,
})

-- Use a dashboard
use({
    'glepnir/dashboard-nvim',
    config = function()
        require('user/plugins/dashboard-nvim')
    end,
})

-- Integrate git
use({
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            -- current_line_blame = true
        })
        vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
        vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
        vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')

    end,
})

use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
})

-- Launch terminal in a window
use({
    'voldikss/vim-floaterm',
    config = function()
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.keymap.set('n', '<C-t>', ':FloatermToggle<CR>')
        vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>')
    end,
})

-- Add support for treesitter
use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('user.plugins.treesitter')
    end,
})

-- Load LSP (Language Server Protocol)
use({
    'neovim/nvim-lspconfig',
    requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'nvimtools/none-ls.nvim',
        'jay-babu/mason-null-ls.nvim',
    },
    config = function()
        require('user/plugins/lspconfig')
    end,
})

-- Configure completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    -- 'hrsh7th/cmp-copilot',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

-- phpactor
use({
    'phpactor/phpactor',
    ft = 'php',
    run = 'composer install --no-dev --optimize-autoloader',
    config = function()
        vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
        vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
    end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

-- Resource the lua file on write.
-- Based on the script:
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
