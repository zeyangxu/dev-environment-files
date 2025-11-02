# Zion's Personal Environment Config Files

## Prerequisites

Install WezTerm, Tmux and Neovim

```bash
brew install --cask wezterm

brew tap homebrew/cask-fonts

brew install font-meslo-lg-nerd-font tmux neovim ripgrep eza zoxide bash
```

Install TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Setup powerline

```bash
brew install powerlevel10k
```

Setup zsh-autosuggestions

```bash
brew install zsh-autosuggestions
```

Setup zsh-syntax-highlighting

```bash
brew install zsh-syntax-highlighting
```

Install Yazi

```bash
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
```

Install CLI Tools

Fd (better find)

```bash
brew install fd

cd

git clone https://github.com/junegunn/fzf-git.sh.git
```

Bat (better cat)

```bash
brew install bat
```

Git-delta (better git diff)

```bash
brew install git-delta
```

Add following to `~/.gitconfig`

```
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true    # use n and N to move between diff sections
    side-by-side = true


    # delta detects terminal colors automatically; set one of these to disable auto-detection
    # dark = true
    # light = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

TLDR (better man pages)

```bash
brew install tlrc
```

## Setup Dotfiles

Clone this repo

```bash
mkdir ~/dotfiles

git clone git@github.com:zeyangxu/dev-environment-files.git ~/dotfiles
```

Symlink the dot files

```bash
brew install stow

cd ~/dotfiles

stow .
```

Install Yazi theme

```bash
# Linux/macOS
git clone https://github.com/BennyOe/tokyo-night.yazi.git ~/dotfiles/yazi/flavors/tokyo-night.yazi

# Windows
git clone https://github.com/BennyOe/tokyo-night.yazi.git %AppData%\yazi\config\flavors\tokyo-night.yazi
```

Update Bat theme

```bash
bat cache --build
```

## Basic Usages

### Yazi file management

Use `y` command to open Yazi

### Neovim text editor

Use `nvim` command to open Neovim

### Fzf

Use `ctrl-t` to start a fzf search

Use `{command} **Tab` to fzf command params suggestions

Use `ctrl-r` to fzf commands

Use `ctrl-g h` to view git commits and select commit hash

Use `ctrl-g b` to view git branches and select commit hash

## CLI Tools

## Vimium config

```
# Insert your preferred key mappings here.
map t Vomnibar.activateTabSelection
map T createTab
map gb visitPreviousTab
```
