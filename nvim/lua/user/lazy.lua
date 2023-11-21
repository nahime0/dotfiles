local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    { import = 'user.lazy.tokyonight' }, -- Include the theme
    { import = 'user.lazy.vim-commentary' }, -- Comment stuff out (use gcc to comment out a line)
    { import = 'user.lazy.vim-surround' }, -- Easily add, change and delete surroundings in pairs (e.g. cs"' to change surrounding " from double quotes to single quotes)
    { import = 'user.lazy.vim-eunuch' }, -- vim enunch - command like :Rename and :SudoWrite
    { import = 'user.lazy.vim-unimpaired' }, -- Map other pair of brackets
    { import = 'user.lazy.vim-sleuth' }, -- Use editorconfig to set up the editor indentations
    { import = 'user.lazy.vim-repeat' }, -- Use vim repeat to allow plugins to repeat actions
    { import = 'user.lazy.vim-tmux-navigator' }, -- Integration with tmux
    { import = 'user.lazy.vim-lastplace' }, -- Return to the last location on a file when opening it
    { import = 'user.lazy.vim-visual-star-search' }, -- Enable * searching also for visual selection
    { import = 'user.lazy.vim-heritage' }, -- Automatically create folders when saving a file
    { import = 'user.lazy.vim-textobj-xmlattr' }, -- Add support for vim objects for HTML attributes
    { import = 'user.lazy.vim-rooter' }, -- Set the working directory to the project root
    { import = 'user.lazy.nvim-autopairs' }, -- Use auto pairs to automatically close brackets
    { import = 'user.lazy.neoscroll' }, -- Use neoscroll to scroll smoothly
    { import = 'user.lazy.bufdelete' }, -- Use bufdelete to delete buffers but keep the split open
    { import = 'user.lazy.treesj' }, -- Split and join arrays (and others) in multiple lines (e.g. gS to split, gJ to join)
    { import = 'user.lazy.vim-pasta' }, -- Use vim pasta to automatically fix indentation when pasting
    { import = 'user.lazy.telescope' }, -- Fuzzy finder
    { import = 'user.lazy.neo-tree' }, -- Side tree
    { import = 'user.lazy.lualine' }, -- Lualine status bar
    { import = 'user.lazy.bufferline' }, -- Currently opened tabs / buffers
    { import = 'user.lazy.indent-blankline' }, -- Indent blank lines
    { import = 'user.lazy.dashboard' }, -- Use a dashbord when starting nvim
    { import = 'user.lazy.gitsigns' }, -- Show git information in the ribbon
    { import = 'user.lazy.vim-fugitive' }, -- Git commands integration
    { import = 'user.lazy.vim-floaterm' }, -- Use terminal in a floating window
    { import = 'user.lazy.nvim-treesitter' }, -- Treesitter - Highligthing and more
    { import = 'user.lazy.nvim-lspconfig' }, -- LSP configuration
    { import = 'user.lazy.nvim-cmp' }, -- Auto completion
    { import = 'user.lazy.phpactor' }, --  phpactor
    { import = 'user.lazy.vim-projectionist' }, -- Project definition
    { import = 'user.lazy.vim-test' }, -- VIM test
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
})
