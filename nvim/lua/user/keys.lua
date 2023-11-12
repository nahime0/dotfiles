--------------------------------------------------------------------------------
-- Global configuration
--------------------------------------------------------------------------------

-- Use space as leader key
vim.g.mapleader         = ' '
vim.g.maplocalleader    = ' '

--------------------------------------------------------------------------------
-- Insert mode mappings
--------------------------------------------------------------------------------

-- Set kj to escape in insert mode
vim.keymap.set('i', 'kj', '<Esc>')

-- Quick insert ; and  , at the end of the line while in insert mode
-- vim.keymap.set('i', ';;', '<Esc>A;')
-- vim.keymap.set('i', ',,', '<Esc>A,')

--------------------------------------------------------------------------------
-- Normal mode mappings
--------------------------------------------------------------------------------

-- When inside a wrapped line, move by visual line, not physical line. Only when
-- we are not providing a count (ex. 5j will still move 5 physical lines down)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Make q: work like :q
vim.keymap.set('n', 'q:', ':q')

-- Cleanup serch highlights
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Open the current file in the default program
vim.keymap.set('n', '<Leader>o', ':!open %<CR><CR>')

--------------------------------------------------------------------------------
-- Visual mode mappings
--------------------------------------------------------------------------------

-- Keep selection when indenting in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keep the cursor when yanking in visual mode
vim.keymap.set('v', 'y', 'myy`y')

-- A paste, in visual mode, should not replace the current selection
-- Delete the selection into the _ register, then paste
vim.keymap.set('v', 'p', '"_dP') 

--------------------------------------------------------------------------------
-- Mixed mode mappings
--------------------------------------------------------------------------------

-- Use ALT+Movement to move line or blocks of lines up and down in the text
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
-- vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
-- vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
-- vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
-- vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")
