# Zion's Personal Environment Config Files

## Prerequisites

Install WezTerm, powerline10k, Tmux and Neovim

```bash
brew install --cask wezterm

brew install font-meslo-lg-nerd-font tmux neovim

brew install powerlevel10k
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
