return {
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-media-files.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",

  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
        git_files = {
          show_untracked = true,
        },
      },
    })
  end,
}
