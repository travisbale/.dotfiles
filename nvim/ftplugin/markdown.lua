vim.opt.spell = true
vim.opt.wrap = true
vim.opt.linebreak = true

vim.api.nvim_set_keymap("n", "<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", { silent = true })
