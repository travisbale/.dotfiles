local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup {
  auto_close = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  view = {
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = { "<Right>", "<CR>", "o"}, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "<Left>", cb = tree_cb "close_node" }
      },
    },
  },
}
