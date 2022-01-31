local options = {
  mouse = "a", -- enable use of the mouse
  clipboard = "unnamedplus", -- allow neovim to access system clipboard
  completeopt = {"menu", "menuone", "noselect"}, -- mostly just for cmp
  number = true, -- enable line numbers
  wrap = false,
  formatoptions = "tcqrn1",
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
  shiftround = false,
  smartindent = true,
  listchars= "tab:→ ,trail:·,lead:·,nbsp:␣,multispace:·",
  list = true,
  hidden = true,
  swapfile = false,
  splitbelow = true,
  splitright = true,
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  signcolumn = "yes",
  scrolloff = 8,
  sidescrolloff = 8,
  cursorline = true,
  termguicolors = true, -- set term gui colors
  background = 'dark',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
