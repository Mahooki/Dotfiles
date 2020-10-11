# Dotfiles

Dotfiles repository that is intended to be cloned bare with the working tree set to $HOME.
This simplifies the process of configuring new OS installs.

## Packages

Installed packages can be backed up to and installed from a list with pacman or yay via:

### Backup

```bash
pacman -Qqe > $HOME/.pacman-packages
```

### Restore

```bash
.config/zsh/.zhistory
pacman -S --needed - < $HOME/.pacman-packages
```

## Setup

```bash
git clone --bare git@github.com:Mahooki/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```

## Example Usage

```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles push
```

