return {
  "nvim-tree/nvim-tree.lua",   -- Tree Explorer

  dependencies = {
    "nvim-tree/nvim-web-devicons",     -- Development icons
  },

  config = function()
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    })
  end,
}
