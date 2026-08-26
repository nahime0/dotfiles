-- Personal plugin specs shared with macOS, excluding the macOS/Nord theme
-- stack and local development-only plugins. Omarchy supplies only the active
-- theme; LazyVim itself is deliberately not loaded.
local modules = {
  "barbecue", "bufferline", "bufdelete", "codecompanion", "copilot",
  "dashboard", "fine-cmdline", "gitsigns", "indent-blankline", "lualine",
  "neo-tree", "neoscroll", "nvim-autopairs", "nvim-cmp", "nvim-lspconfig",
  "nvim-treesitter", "phpactor", "telescope", "treesj", "vim-commentary",
  "vim-eunuch", "vim-floaterm", "vim-fugitive", "vim-heritage",
  "vim-lastplace", "vim-pasta", "vim-projectionist", "vim-repeat",
  "vim-rooter", "vim-sleuth", "vim-surround", "vim-test",
  "vim-textobj-xmlattr", "vim-tmux-navigator", "vim-unimpaired",
  "vim-visual-star-search",
}

local specs = {}
for _, name in ipairs(modules) do
  local module_specs = require("dotfiles_legacy.lazy." .. name)
  if type(module_specs[1]) == "string" then
    table.insert(specs, module_specs)
  else
    vim.list_extend(specs, module_specs)
  end
end

return specs
