# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS development environment using GNU Stow for symlink management. All configs use Tokyo Night theme.

## Structure

- **Root level**: Main config files (.zshrc, .tmux.conf, .wezterm.lua, .p10k.zsh)
- **.config/**: Application configs (nvim/, yazi/, bat/)
- **Neovim**: Located in `.config/nvim/lua/zion/` with modular plugin structure

## Installation & Setup

**Prerequisites** (via Homebrew):

```bash
brew install --cask wezterm
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font tmux neovim ripgrep eza zoxide bash
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
brew install bat git-delta tlrc stow
```

**TPM** (Tmux Plugin Manager):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

**Yazi theme**:

```bash
git clone https://github.com/BennyOe/tokyo-night.yazi.git ~/dotfiles/.config/yazi/flavors/tokyo-night.yazi
```

**Deploy dotfiles**:

```bash
cd ~/dotfiles && stow .
```

**Post-install**:

- Bat: `bat cache --build`
- Tmux: `Ctrl-A Shift-I` (install plugins)

## Key Configuration Files

### Tmux (.tmux.conf)

- Prefix: `Ctrl-A` (not default `Ctrl-B`)
- Split: `|` (vertical), `-` (horizontal)
- Resize: `h/j/k/l` (by 5 units)
- Reload: `r`
- Plugins: vim-tmux-navigator, tokyo-night theme, resurrect, continuum

### Zsh (.zshrc)

Key aliases:

- `ls/ll/lt/l`: eza variants
- `lg`: lazygit
- `ta/tas/tl/tn/tns/tks`: tmux shortcuts
- `cc`: claude code
- `y`: yazi with cd-on-quit
- `rub/rs/rsp/rsc/rrs/rb/ra`: Rush monorepo commands

Tools configured:

- Powerlevel10k prompt
- zoxide (better cd)
- fzf with fd integration
- bat (BAT_THEME=tokyonight_night)
- neovim-remote for nested nvim

### Neovim (.config/nvim)

**Structure**:

- `lua/zion/core/`: Basic options, keymaps, autocmds
- `lua/zion/plugins/`: Plugin configs (managed by lazy.nvim)
- `lua/zion/lsp.lua`: LSP keybindings
- `lua/zion/plugins/lsp/mason.lua`: LSP/linter/formatter installations

**LSP servers**: ts_ls, html, cssls, tailwindcss, lua_ls, pyright, eslint, thriftls

**Formatters**: prettierd, stylua

**Key plugins**:

- lazy.nvim (plugin manager)
- mason.nvim + mason-lspconfig
- nvim-cmp (completion)
- telescope.nvim (fuzzy finder)
- neo-tree (file explorer)
- nvim-treesitter
- gitsigns, diffview, lazygit.nvim
- auto-session
- which-key
- tokyo-night theme

**Custom keybindings** (check lua/zion/lsp.lua and plugin configs):

- LSP: `gd`, `gD`, `gr`, `gt` (definitions/references/types)
- Code actions: `<leader>ca`
- Rename: `<leader>rn`
- Diagnostics: `<leader>D` (buffer), `<leader>d` (line)

### Yazi (.config/yazi)

- Theme: Tokyo Night
- Keymap customizations in keymap.toml
- Use `y` command in shell to launch with cd-on-quit

## Development Workflow

When editing configs:

1. **Neovim plugins**: Modify files in `.config/nvim/lua/zion/plugins/`, Lazy.nvim auto-manages
2. **Tmux**: Edit `.tmux.conf`, reload with `Ctrl-A r` or restart tmux
3. **Zsh**: Edit `.zshrc`, reload with `source ~/.zshrc`
4. **Symlinks**: After pulling changes, run `stow .` in ~/dotfiles

## Git Configuration

Required in `~/.gitconfig` for git-delta:

```
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    side-by-side = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

## Package Managers

- **Node**: nvm (loaded in .zshrc)
- **JavaScript**: pnpm (path: ~/Library/pnpm)
- **Python**: pipx (path: ~/.local/bin)
- **Bun**: BUN_INSTALL=$HOME/.bun

## Useful Shell Shortcuts

- **fzf**: `Ctrl-T` (file search), `Ctrl-R` (command history), `Ctrl-G H` (git commits), `Ctrl-G B` (git branches)
- **yazi**: `y` (launch file manager with cd-on-quit)
- **command completion**: `{command} **<Tab>` for fzf completion
