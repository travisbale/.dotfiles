local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down macos
keymap("n", "∆", ":m .+1<CR>==", opts)
keymap("n", "˚", ":m .-2<CR>==", opts)
keymap("v", "∆", ":m '>+1<CR>gv=gv", opts)
keymap("v", "˚", ":m '<-2<CR>gv=gv", opts)
-- Move text up and down linux
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Telescope mappings
keymap("n", "<C-p>", "<cmd>Telescope git_files<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- Nvimtree
keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", opts)
keymap("n", "<C-\\>", "<cmd>NvimTreeFindFileToggle<CR>", opts)

-- Jumplist
keymap("n", "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', opts)
keymap("n", "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', opts)

-- Git

