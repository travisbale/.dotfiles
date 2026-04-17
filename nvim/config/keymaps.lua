local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down macos
keymap("n", "∆", ":m .+1<CR>==")
keymap("n", "˚", ":m .-2<CR>==")
keymap("v", "∆", ":m '>+1<CR>gv=gv")
keymap("v", "˚", ":m '<-2<CR>gv=gv")
-- Move text up and down linux
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Keep cursor vertically centered when moving vertically
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Tmux navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Save shortcut
keymap("i", "<C-s>", "<Esc>:w<CR>")
keymap("n", "<C-s>", "<Esc>:w<CR>")

-- Rails mappings
keymap("n", "<leader>rt", "<cmd>Rails<CR>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Telescope mappings
keymap("n", "<C-p>", "<cmd>Telescope git_files<CR>")
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- Nvimtree
keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>")
keymap("n", "<C-\\>", "<cmd>NvimTreeFindFile<CR>")

-- Jumplist
keymap("n", "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
keymap("n", "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')

-- Map W and Q to their lowercase equivalents
keymap("n", ":W", ":w")
keymap("n", ":Q", ":q")

-- Clear highlighting on escape in normal mode
keymap("n", "<esc>", "<cmd>noh<CR><esc>")
keymap("n", "<esc>^[", "<esc>^[")
