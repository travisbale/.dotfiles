return {
    "nvimtools/none-ls.nvim", -- Support non LSP sources

    config = function()
        local null_ls = require("null-ls")
        local base_dir = os.getenv("HOME") .. "/.dotfiles"

        null_ls.setup({
            debug = false,
            sources = {
                -- Formatters
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.stylua.with({
                    command = base_dir .. "/bin/stylua",
                    extra_args = { "--indent-type", "Spaces" },
                }),
                null_ls.builtins.formatting.markdownlint.with({
                    command = base_dir .. "/node_modules/.bin/markdownlint",
                }),
                null_ls.builtins.formatting.black.with({
                    command = base_dir .. "/.venv/bin/black",
                }),

                -- Diagnostics
                null_ls.builtins.diagnostics.markdownlint.with({
                    command = base_dir .. "/node_modules/.bin/markdownlint",
                    extra_args = { "--disable", "MD013" },
                }),
            },
        })
    end,
}
