local null_ls = require("null-ls")
local base_dir = os.getenv("HOME") .. "/.dotfiles/nvim"

null_ls.setup({
    debug = false,
    sources = {
        -- Formatters
        null_ls.builtins.formatting.goimports.with({
            command = base_dir .. "/bin/goimports",
        }),
        null_ls.builtins.formatting.stylua.with({
            command = base_dir .. "/bin/stylua",
            extra_args = { "--indent-type", "Spaces" },
        }),

        -- Diagnostics
        null_ls.builtins.diagnostics.markdownlint.with({
            command = base_dir .. "/node_modules/.bin/markdownlint",
        }),
    },
})
