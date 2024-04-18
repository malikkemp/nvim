-- Load lazy.nvim and configuration plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Install lazy.nvim if not already installed
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


-- Load plugins using lazy.vim
local plugins = {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim' }},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }  
}
local opts = {}
require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "python", "c", "vim"},
  highlight = {enable = true},
  indent = {enable = true},
})
