return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").install({
            -- Shell / scripting
            "bash",
            -- Systems
            "c", "cpp", "rust", "asm",
            -- Web
            "css", "html", "javascript", "jsdoc", "tsx", "typescript", "vue",
            -- Compiled
            "go", "gomod", "gosum", "java", "kotlin",
            -- Dynamic
            "lua", "python", "ruby", "php",
            -- Config / data
            "json", "yaml", "toml", "xml", "sql",
            -- Infra / build
            "dockerfile", "make", "cmake", "terraform", "hcl",
            -- Docs
            "markdown", "markdown_inline", "vim", "vimdoc",
            -- Git
            "diff", "gitcommit", "gitignore", "gitattributes", "git_config",
            -- Misc
            "proto", "regex", "comment",
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
