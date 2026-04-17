return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").install({
            "bash", "css", "go", "gomod", "gosum", "html", "javascript",
            "json", "lua", "markdown", "markdown_inline", "proto", "python",
            "ruby", "sql", "tsx", "typescript", "vim", "vimdoc", "vue", "yaml",
        })

        -- Enable treesitter highlighting globally
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
