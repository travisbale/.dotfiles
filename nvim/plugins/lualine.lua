return {
  "nvim-lualine/lualine.nvim",   -- Status bar

  config = function()
    require("lualine").setup({
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
          },
        },
      },
    })
  end,
}
