-- The install script writes this marker when run with --minimal and removes it
-- on a full install. Minimal machines get the editor, colorscheme, keymaps and
-- highlighting, but none of the LSP/formatter tooling that needs Go, Node, etc.
local marker = vim.fn.stdpath("config") .. "/.minimal"

return {
    minimal = (vim.uv or vim.loop).fs_stat(marker) ~= nil,
}
