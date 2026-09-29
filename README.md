# Dotfiles

Personal configuration files for a Linux development environment.

## What's here

| Config      | Path                  |
| ----------- | --------------------- |
| Neovim      | `nvim/`               |
| Zsh         | `zsh/`                |
| Tmux        | `tmux/`               |
| Alacritty   | `alacritty/`          |
| Git         | `.gitconfig`          |

## Install

```bash
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./install
```

This symlinks configs into place and installs Neovim from the GitHub release pinned in the script.

For machines that aren't used for development (e.g. a Raspberry Pi), use:

```bash
./install --minimal
```

This sets up the shell and Neovim with the same colorscheme, keymaps and Treesitter highlighting, but skips LSP servers, formatters, markdown-preview, the Go/Node toolchains, the Nerd Font and git signing, and builds a shorter parser list. The choice is recorded in `~/.config/nvim/.minimal`. To upgrade later, run `./install` again without the flag.

## Scripts

| Script                           | Purpose                                                    |
| -------------------------------- | ---------------------------------------------------------- |
| `./install [--minimal]`          | Create symlinks, install Neovim (`--minimal`: no dev tools) |
| `./scripts/test`                 | Smoke tests — symlinks, config syntax, Lua parse checks    |
| `./scripts/update-zsh-plugins`   | Re-download pinned zsh plugin versions into `zsh/`         |
| `./scripts/toggle-theme`         | Switch onedark ↔ gruvbox for Neovim and tmux               |

## Notes

- **Neovim** uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and [Mason](https://github.com/mason-org/mason.nvim) for LSP servers, formatters, and linters. No external package manager (npm, pip) is required.
- **Zsh plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are vendored in `zsh/` at pinned versions. Bump the constants in `update-zsh-plugins` and re-run it to upgrade.
- **Adding a new symlink:** add a line to the `LINKS` array at the top of `install`.
- **Adding an LSP server:** add a new file at `nvim/plugins/lsp/<server>.lua` returning the options table. `plugins/lsp.lua` auto-loads any Mason-installed server with a matching config file.
