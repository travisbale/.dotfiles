return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        { "williamboman/mason-lspconfig.nvim", config = function() end }, -- Bridges nvim-lspconfig with mason.nvim
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
        local lspconfig = require("lspconfig")

        mason.setup()

        local function lsp_highlight_document(client)
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
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-Space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "[d",
                '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
                opts
            )
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "gl",
                '<cmd>lua vim.diagnostic.open_float({ border = "rounded", source = true })<CR>',
                opts
            )
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "]d",
                '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
                opts
            )
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-q>", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
            vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
        end

        local function on_attach(client, bufnr)
            lsp_keymaps(bufnr)
            lsp_highlight_document(client)

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("Format", {}),
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

            lspconfig[server].setup(opts)
        end
    end,
}
