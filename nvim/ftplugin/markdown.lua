vim.opt.spell = true

vim.api.nvim_set_keymap("n", "<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", { silent = true })
