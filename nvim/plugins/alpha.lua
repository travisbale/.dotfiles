return {
  "goolord/alpha-nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",     -- Development icons
  },

  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find git file", ":Telescope git_files <CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
      dashboard.button("a", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Grep text", ":Telescope live_grep <CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    require("alpha").setup(dashboard.opts)
  end,
}
