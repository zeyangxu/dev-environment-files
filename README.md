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

## Vimium config

```
# Insert your preferred key mappings here.
map t Vomnibar.activateTabSelection
map T createTab
map gb visitPreviousTab
```
