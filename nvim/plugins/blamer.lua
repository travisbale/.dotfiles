return {
    "APZelos/blamer.nvim",

    config = function()
        vim.cmd("let g:blamer_enabled = 1")
        vim.cmd("let g:blamer_delay = 500")
        vim.cmd("let g:blamer_prefix = '      '")
    end,
}
