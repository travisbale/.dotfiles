require("nvim-lsp-installer").setup({})

local lspconfig = require("lspconfig")
local servers = {
    "bashls",
    "cssls",
    "dockerls",
    "eslint",
    "foam_ls",
    "golangci_lint_ls",
    "gopls",
    "grammarly",
    "graphql",
    "html",
    "jsonls",
    "jdtls",
    "sumneko_lua",
    "pyright",
    "tailwindcss",
    "terraformls",
    "tsserver",
    "vuels",
    "yamlls",
}

lspconfig.jsonls.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("config.lsp.handlers").on_attach,
        capabilities = require("config.lsp.handlers").capabilities,
    }

    local has_custom_opts, custom_ops = pcall(require, 'config.lsp.settings.' .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", custom_ops, opts)
    end

    lspconfig[server].setup(opts)
end

