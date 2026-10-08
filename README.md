# Dotfiles

Personal dotfiles repository.

## Installation

```bash
git clone https://github.com/catalinstir/dotfiles.git ~/.dotfiles

sudo apt update
sudo apt install stow
## or 'brew install stow' or 'dnf install stow'

## for individual configurations (zsh for example)
stow zsh

## or for multiple configurations
stow zsh nvim tmux
```

### Zsh

```bash
# For oh-my-zsh (install zsh first)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# For zsh plugin
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```

### Nvim 
```bash
sudo apt install fzf ripgrep unzip tree-sitter-cli python3 python3-venv python3-pip clang-format
```

2025-11-26.
