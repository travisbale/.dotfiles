-- Automatically install packer if it has not been installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- Package Manager
    use("wbthomason/packer.nvim") -- Have packer manage itself

    -- Common dependencies
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

    -- Editor plugins
    use("navarasu/onedark.nvim") -- Colorscheme
    use("windwp/nvim-autopairs") -- Bracket completion
    use("windwp/nvim-ts-autotag") -- Tag completion
    use("numToStr/Comment.nvim") -- Comment lines
    use("nvim-tree/nvim-tree.lua") -- Tree Explorer
    use("nvim-tree/nvim-web-devicons") -- Development icons
    use("nvim-lualine/lualine.nvim") -- Status bar
    use("goolord/alpha-nvim") -- Neovim greeter
    use("folke/which-key.nvim") -- Key binding suggestions
    use("img-paste-devs/md-img-paste.vim") -- Paste clipboard images to md files
    use("tpope/vim-surround") -- Mappings for working with brackets, quotes, and tags
    use("tpope/vim-endwise") -- Add 'end' after 'if', 'def', etc

    -- Neovim config and plugin development
    use("folke/neodev.nvim")

    -- Test plugins
    use("nvim-neotest/neotest") -- Framework for interacting with tests
    use("nvim-neotest/nvim-nio") -- Library for asynchronous IO
    use("nvim-neotest/neotest-go") -- Neotest adapater for go
    use("nvim-neotest/neotest-python") -- Neotest adapater for python
    use("nvim-neotest/neotest-vim-test") -- Neotest adapater for vim-test
    use("olimorris/neotest-rspec") -- Neotest adapter for rspec
    use("vim-test/vim-test") -- Wrapper for running tests on different granularities
    use("tpope/vim-cucumber") -- Commands to jump from steps to definitions

    -- Language plugins
    use("vim-ruby/vim-ruby") -- Ruby
    use("tpope/vim-rails") -- Ruby on Rails
    use("kchmck/vim-coffee-script") -- Coffeescript syntax highlighting

    -- Git
    use("lewis6991/gitsigns.nvim") -- Git integration
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("rhysd/git-messenger.vim")
    use("APZelos/blamer.nvim")

    -- Autocomplete
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-nvim-lsp") -- LSP completions
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("simrat39/symbols-outline.nvim") -- View LSP symbols

    -- snippets
    use("L3MON4D3/LuaSnip") --snippet engine
    use("rafamadriz/friendly-snippets") -- snippet collection

    -- Language Server Protocol
    use("neovim/nvim-lspconfig") -- enable LSP
    use("williamboman/mason.nvim") -- LSP Installer
    use("williamboman/mason-lspconfig.nvim") -- Bridges nvim-lspconfig with mason.nvim
    use("jose-elias-alvarez/null-ls.nvim") -- Support non LSP sources

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
