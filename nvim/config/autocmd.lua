vim.cmd [[
    autocmd BufWritePost * execute 'lua vim.lsp.buf.formatting()'
]]
