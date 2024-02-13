-- Basic information on how to use Lua in neovim:
-- https://github.com/nanotee/nvim-lua-guide

-- Plugins
-- require('user/plugins')

-- User settings
require('user/options')
require('user/keys')

-- Lazy
require('user/lazy')


-- Force snippets filetype for .snippets files
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.snippets",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", "snippets")
    end,
})
