-- Run the personal Neovim configuration without importing LazyVim, while
-- retaining Omarchy's current theme and its theme hot-reload integration.
require("dotfiles_legacy.options")
require("dotfiles_legacy.keys")

vim.keymap.set("n", "<leader>o", function()
  vim.ui.open(vim.fn.expand("%:p"))
end, { desc = "Open current file in the default application" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

local theme_specs = require("plugins.theme")
local active_colorscheme
-- Omarchy registers every supported colorscheme as lazy so a theme switch can
-- load it immediately without restarting Neovim.
local specs = require("plugins.all-themes")

for _, spec in ipairs(theme_specs) do
  if spec[1] == "LazyVim/LazyVim" then
    active_colorscheme = spec.opts and spec.opts.colorscheme
  else
    table.insert(specs, spec)
  end
end

vim.list_extend(specs, require("omarchy_profile.dotfiles"))
vim.list_extend(specs, require("plugins.omarchy-theme-hotreload"))

require("lazy").setup(specs, {
  lockfile = vim.fn.stdpath("state") .. "/dotfiles-lazy-lock.json",
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  install = { colorscheme = active_colorscheme and { active_colorscheme } or { "habamax" } },
})

require("omarchy_profile.theme-watch")

if active_colorscheme then
  vim.cmd.colorscheme(active_colorscheme)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.snippets",
  callback = function(args)
    vim.bo[args.buf].filetype = "snippets"
  end,
})
