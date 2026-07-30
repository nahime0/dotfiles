-- Basic information on how to use Lua in neovim:
-- https://github.com/nanotee/nvim-lua-guide

-- Plugins
-- require('user/plugins')

-- Match the macOS appearance before plugins render their first frame. The
-- auto-dark-mode plugin keeps the theme synchronized after startup.
if vim.fn.has('macunix') == 1 then
  local macos_appearance = vim.fn.system({
    'defaults',
    'read',
    '-g',
    'AppleInterfaceStyle',
  })

  if macos_appearance:match('Dark') then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
    vim.cmd.colorscheme('nord-light')
  end
end

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
