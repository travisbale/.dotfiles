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
./install          # shell + lightweight Neovim
./install --full   # also the development tooling
```

The script targets Debian/Ubuntu (it uses `apt`) and needs `sudo`. By default it:

- symlinks the configs into place, asking whether to back up, replace or skip any real file already at a target
- creates `~/.zshrc.local` for machine-specific shell settings, if it doesn't exist yet
- installs the apt packages the shell and Neovim need (skipping any the distro doesn't provide)
- installs the latest stable Neovim, and the `tree-sitter-cli` version pinned at the top of the script, from their GitHub releases
- sets zsh as the default shell

That gives Neovim the same colorscheme, keymaps and Treesitter highlighting everywhere, which suits machines that aren't used for development, like a Raspberry Pi. `--full` adds:

- the Go, Node and Python toolchains Mason uses to install LSP servers, formatters and linters
- the DroidSansMono Nerd Font used by Alacritty, if Alacritty is installed (fonts are drawn by the terminal you're looking at, so a machine you only connect to, like a container or SSH host, doesn't need it)
- a GPG key for signed git commits, stored in `~/.gitconfig.local` (prompts for your email)
- git fetches from GitHub over SSH, for private repos and Go modules

Neovim turns on its development plugins (everything in `nvim/plugins/dev/`) and builds its full parser list only when it finds `go` and `npm`, so there is no profile to keep track of. To upgrade a machine later, run `./install --full`.

It is safe to re-run: steps that are already done are skipped, and nothing is uninstalled, so running without `--full` on a machine that had it changes nothing.

The prebuilt `tree-sitter` binary needs glibc 2.39 or newer. On older systems (e.g. Debian bookworm) the script skips it, and Neovim uses its built-in parsers instead of building more.

## Updating

```bash
cd ~/.dotfiles && git pull && ./install
```

This upgrades Neovim to the latest stable release on any machine, without needing `--full` again. Two things it doesn't update:

- **Plugins and parsers**, which Neovim manages: run `:Lazy update`, then `:TSUpdate` so the parsers match the updated nvim-treesitter queries.
- **tree-sitter-cli**, which is pinned: bump `TREE_SITTER_VERSION` in `install` and re-run it.

## Scripts

| Script                           | Purpose                                                    |
| -------------------------------- | ---------------------------------------------------------- |
| `./install [--full]`             | Link configs and install tools (`--full`: dev tooling too) |
| `./scripts/test`                 | Smoke tests — symlinks, config syntax, Lua parse checks    |
| `./scripts/update-zsh-plugins`   | Re-download pinned zsh plugin versions into `zsh/`         |
| `./scripts/toggle-theme`         | Switch onedark ↔ gruvbox for Neovim, tmux and Alacritty    |

## Notes

- **Neovim** uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and [Mason](https://github.com/mason-org/mason.nvim) for LSP servers, formatters, and linters. Mason builds some of these with Go, Node and Python, which `./install --full` provides via apt.
- **Zsh plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are vendored in `zsh/` at pinned versions. Bump the constants in `update-zsh-plugins` and re-run it to upgrade.
- **Optional tools** (Go, Cargo, nvm, the Google Cloud SDK) are wired into the shell only if they are installed, so the same config works on machines without them. When installing a tool like gcloud, decline its offer to edit `~/.zshrc` — that file is a symlink into this repo — and add a guarded hook here instead.
- **Machine-specific git settings** (email, signing key) live in `~/.gitconfig.local`, which `.gitconfig` includes and is not versioned.
- **GitHub over SSH:** `.gitconfig` sends only pushes over SSH, so machines without a key can still pull public repos over HTTPS. `./install --full` also routes fetches over SSH (in `~/.gitconfig.local`), which Go needs to download private modules.
- **Machine-specific shell settings** go in `~/.zshrc.local`, which `.zshrc` sources last and is not versioned. Install creates it from `zsh/.zshrc.local.example` if it doesn't exist, and never overwrites it. The example lists prompt color pairs: `PROMPT_COLOR` (the prompt's lines, default green) and `PROMPT_HOST_COLOR` (user@host and the `$`, default cyan), so you can tell machines apart at a glance.
- **Adding a new symlink:** add a line to the `LINKS` array at the top of `install`.
- **Adding a development-only plugin:** put its spec in `nvim/plugins/dev/`. Plugins anywhere else in `nvim/plugins/` load on every machine.
- **Adding an LSP server:** add a new file at `nvim/plugins/dev/lsp/<server>.lua` returning the options table. `plugins/dev/lsp.lua` auto-loads any Mason-installed server with a matching config file.
