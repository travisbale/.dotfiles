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

## Scripts

| Script                           | Purpose                                                    |
| -------------------------------- | ---------------------------------------------------------- |
| `./install`                      | Create symlinks, install Neovim                            |
| `./scripts/test`                 | Smoke tests — symlinks, config syntax, Lua parse checks    |
| `./scripts/update-zsh-plugins`   | Re-download pinned zsh plugin versions into `zsh/`         |

## Notes

- **Neovim** uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and [Mason](https://github.com/mason-org/mason.nvim) for LSP servers, formatters, and linters. No external package manager (npm, pip) is required.
- **Zsh plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are vendored in `zsh/` at pinned versions. Bump the constants in `update-zsh-plugins` and re-run it to upgrade.
- **Adding a new symlink:** add a line to the `LINKS` array at the top of `install`.
- **Adding an LSP server:** add a new file at `nvim/plugins/lsp/<server>.lua` returning the options table. `plugins/lsp.lua` auto-loads any Mason-installed server with a matching config file.
