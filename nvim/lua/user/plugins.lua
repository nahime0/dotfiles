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
--    display = {
--        open_fn = function()
--            return require('packer.util').float({ border = 'solid' })
--        end
--    },
})

-- require the packer use function
local use = require('packer').use

-- Include plugins
use('wbthomason/packer.nvim')

-- Include vim commentary
use('tpope/vim-commentary')

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
