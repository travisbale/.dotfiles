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

The script targets Debian/Ubuntu (it uses `apt`) and needs `sudo`. It:

- symlinks the configs into place, asking whether to back up, replace or skip any real file already at a target
- installs the apt packages the shell and Neovim tooling need (skipping any the distro doesn't provide)
- installs the latest stable Neovim, and the `tree-sitter-cli` version pinned at the top of the script, from their GitHub releases
- installs the DroidSansMono Nerd Font used by Alacritty
- sets zsh as the default shell
- generates a GPG key for signed git commits, stored in `~/.gitconfig.local` (prompts for your email)

It is safe to re-run: steps that are already done are skipped. Re-running also upgrades Neovim to the latest stable release. To upgrade tree-sitter, bump `TREE_SITTER_VERSION` and run it again.

The prebuilt `tree-sitter` binary needs glibc 2.39 or newer. On older systems (e.g. Debian bookworm, Raspberry Pi OS) the script skips it, and Neovim uses its built-in parsers instead of building more.

For machines that aren't used for development (e.g. a Raspberry Pi), use:

```bash
./install --minimal
```

This sets up the shell and Neovim with the same colorscheme, keymaps and Treesitter highlighting, but skips LSP servers, formatters, markdown-preview, the Go/Node toolchains, the Nerd Font and git signing, and builds a shorter parser list. The choice is recorded in `~/.config/nvim/.minimal`. To upgrade later, run `./install` again without the flag.

## Scripts

| Script                           | Purpose                                                    |
| -------------------------------- | ---------------------------------------------------------- |
| `./install [--minimal]`          | Link configs and install tools (`--minimal`: no dev tools) |
| `./scripts/test`                 | Smoke tests — symlinks, config syntax, Lua parse checks    |
| `./scripts/update-zsh-plugins`   | Re-download pinned zsh plugin versions into `zsh/`         |
| `./scripts/toggle-theme`         | Switch onedark ↔ gruvbox for Neovim, tmux and Alacritty    |

## Notes

- **Neovim** uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and [Mason](https://github.com/mason-org/mason.nvim) for LSP servers, formatters, and linters. Mason builds some of these with Go, Node and Python, which the full install provides via apt.
- **Zsh plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are vendored in `zsh/` at pinned versions. Bump the constants in `update-zsh-plugins` and re-run it to upgrade.
- **Optional tools** (Go, Cargo, nvm, the Google Cloud SDK) are wired into the shell only if they are installed, so the same config works on machines without them. When installing a tool like gcloud, decline its offer to edit `~/.zshrc` — that file is a symlink into this repo — and add a guarded hook here instead.
- **Machine-specific git settings** (email, signing key) live in `~/.gitconfig.local`, which `.gitconfig` includes and is not versioned.
- **Adding a new symlink:** add a line to the `LINKS` array at the top of `install`.
- **Adding an LSP server:** add a new file at `nvim/plugins/lsp/<server>.lua` returning the options table. `plugins/lsp.lua` auto-loads any Mason-installed server with a matching config file.
