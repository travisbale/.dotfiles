vim.g.indent_blankline_char = "▏"

-- Set the inactive indent line color to the comment color
vim.cmd [[highlight IndentBlanklineIndent guifg=#4d535e gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#858992 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextStart gui=none]]

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    -- show_current_context_start = true,
    space_char_blankline = " ",
    -- char_highlight_list = {
    --     "IndentBlanklineIndent",
    -- },
}

