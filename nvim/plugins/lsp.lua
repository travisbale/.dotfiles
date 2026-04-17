return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "mason-org/mason.nvim",
        { "mason-org/mason-lspconfig.nvim", config = function() end },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = {
                    "markdownlint",
                    "goimports",
                    "stylua",
                    "black",
                },
            },
        },
    },

    config = function()
        local signs = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        }

        vim.diagnostic.config({
            virtual_text = {
                prefix = function(diagnostic)
                    return string.format("%s ", signs[diagnostic.severity])
                end,
            },
            signs = {
                text = signs,
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                border = "rounded",
                source = true,
                severity_sort = true,
                header = "",
                prefix = "",
            },
        })

        require("mason").setup()

        local mason = require("mason-lspconfig")

        mason.setup()

        local function lsp_highlight_document(client, bufnr)
            -- Set autocommands conditional on server_capabilities
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = vim.lsp.buf.document_highlight,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Document Highlight",
                })
                vim.api.nvim_create_autocmd("CursorMoved", {
                    callback = vim.lsp.buf.clear_references,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Clear All the References",
                })
            end
        end

        local function lsp_keymaps(bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-Space>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev({ float = { border = "rounded" } })
            end, opts)
            vim.keymap.set("n", "gl", function()
                vim.diagnostic.open_float({ border = "rounded", source = true })
            end, opts)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_next({ float = { border = "rounded" } })
            end, opts)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
            vim.keymap.set("n", "<C-q>", vim.diagnostic.setqflist, opts)
            vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
        end

        local format_augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })

        local function on_attach(client, bufnr)
            lsp_keymaps(bufnr)
            lsp_highlight_document(client, bufnr)

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = format_augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end
        end

        for _, server in pairs(mason.get_installed_servers()) do
            local opts = {
                on_attach = on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }

            local has_custom_opts, custom_opts = pcall(require, "plugins.lsp." .. server)

            if has_custom_opts then
                opts = vim.tbl_deep_extend("force", custom_opts, opts)
            end

            vim.lsp.config(server, opts)
        end
    end,
}
