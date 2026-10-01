return {
    "nvimtools/none-ls.nvim",

    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            debug = false,
            sources = {
                -- Formatters
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces" },
                }),
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.formatting.black,

                -- Diagnostics
                null_ls.builtins.diagnostics.markdownlint.with({
                    extra_args = { "--disable", "MD013" },
                }),
            },
        })
    end,
}
