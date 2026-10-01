-- Automatically install packer if it has not been installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Set basic options and keymaps
require("config.options")
require("config.keymaps")

-- The development plugins (LSP servers, formatters, etc.) rely on Mason, which
-- needs Go and Node to install its tools. `./install --full` provides them;
-- without them, load only the plugins in lua/plugins/ and skip lua/plugins/dev/.
vim.g.dev_tools = vim.fn.executable("go") == 1 and vim.fn.executable("npm") == 1

-- Install and configure plugins
local spec = { { import = "plugins" } }
if vim.g.dev_tools then
    table.insert(spec, { import = "plugins.dev" })
end
require("lazy").setup({ spec = spec })
