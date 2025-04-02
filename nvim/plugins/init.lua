return {
  -- Common dependencies
  "nvim-lua/popup.nvim",                      -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", lazy = true },   -- Useful lua functions used by lots of plugins

  -- Miscellaneous plugins
  "windwp/nvim-ts-autotag",            -- Tag completion
  "img-paste-devs/md-img-paste.vim",   -- Paste clipboard images to md files
  "tpope/vim-surround",                -- Mappings for working with brackets, quotes, and tags
  "tpope/vim-endwise",                 -- Add 'end' after 'if', 'def', etc
}
