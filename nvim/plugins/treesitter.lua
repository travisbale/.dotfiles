local parsers = {
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
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,

    config = function()
        -- max_jobs = 1 installs parsers one at a time so startup doesn't
        -- peg CPU on resource-constrained machines. Already-installed
        -- parsers are a no-op, so this is only slow on first run.
        -- Without tree-sitter-cli (the install script skips it on systems too
        -- old for the release binary) parsers can't be built; fall back to the
        -- ones bundled with Neovim instead of erroring on every launch.
        if vim.fn.executable("tree-sitter") == 1 then
            require("nvim-treesitter").install(parsers, { max_jobs = 1 })
        end

        -- Enable treesitter highlighting globally
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
