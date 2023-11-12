-- Tab management
-- Use spaces instead of tabs
-- Set tab, shiftwidth, and softtabstop to 4
-- Enable smartindent, automatically indent code in common blocks
vim.opt.expandtab       = true
vim.opt.shiftwidth      = 4
vim.opt.tabstop         = 4
vim.opt.softtabstop     = 4
vim.opt.smartindent     = true

-- Do not wrap lines, use horizontal scroll instead
vim.opt.wrap = false

-- Line numbers and relative line numbers to the current line
vim.opt.number          = true
vim.opt.relativenumber  = true

-- Wild mode, tab completion. Use longest match, then full match
vim.opt.wildmode = 'longest:full,full'

-- Set the title of the window - tmux
vim.opt.title = true

-- Enable the mouse in all modes
vim.opt.mouse = 'a'

-- Enable GUI colors
vim.opt.termguicolors = true

-- Enable spell checking
vim.opt.spell = true

-- Search case insensitive
vim.opt.ignorecase  = true
vim.opt.smartcase   = true

-- Render non-printable characters with a special symbol
vim.opt.list = true
vim.opt.listchars = {
    tab         = '▸ ',
    trail       = '·',
--    extends     = '…',
--    precedes    = '…',
--    nbsp        = '␣',
--    eol         = '↲',
}

-- Remove the ~ at the end of the file
vim.opt.fillchars:append({ eob = ' ' })

-- Define how to create new splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Keep the cursor in the middle of the screen
vim.opt.scrolloff       = 8
vim.opt.sidescrolloff   = 8

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Use confirmation instead of error messages (ask for file save, etc)
vim.opt.confirm = true

-- Enable the persistent (within sessions) undo feature and backups.
-- Don't save backups in the current directory
vim.opt.undofile    = true
vim.opt.backup      = true
vim.opt.backupdir:remove('.')
