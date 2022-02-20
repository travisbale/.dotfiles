-- Automatically install packer

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Package Manager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Default settings
  use 'tpope/vim-sensible' -- Set some sensible defaults for vim

  -- Common dependencies
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons" -- Development icons

  -- Editor plugins
  use 'navarasu/onedark.nvim' -- Colorscheme
  use "windwp/nvim-autopairs" -- Bracket completion
  use "numToStr/Comment.nvim" -- Comment lines
  use "kyazdani42/nvim-tree.lua" -- Tree Explorer
  use 'nvim-lualine/lualine.nvim' -- Status bar
  use 'goolord/alpha-nvim' -- Neovim greeter
  use 'folke/which-key.nvim' -- Key binding suggestions
  use 'ahmedkhalf/project.nvim' -- Project management
  use 'ThePrimeagen/vim-be-good' -- Vim Practice game
  use 'ferrine/md-img-paste.vim' -- Paste clipboard images to md files

  -- Git
  use "lewis6991/gitsigns.nvim" -- Git integration
  use "tpope/vim-fugitive"

  -- Autocomplete
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use 'rafamadriz/friendly-snippets' -- snippet collection

  -- Language Server Protocol
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- LSP Installer
  use "jose-elias-alvarez/null-ls.nvim" -- Support non LSP sources

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
