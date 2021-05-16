##################
#      ZSHRC     #
##################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Enable colors:
autoload -U colors && colors
colors

# Navigation:
setopt AUTO_CD			# Go to folder path without using cd.
setopt EXTENDED_GLOB		# Use extended globbing syntax.
setopt AUTO_PUSHD		# Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS	# Do not store duplicates in the stack.
setopt PUSHD_SILENT		# Do not print the directory stack after pushd or popd

# Remove duplicates from history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

# Disable sound
unsetopt BEEP

# Disable tty flow control, allows vim to use '<Ctrl>S'
unsetopt FLOW_CONTROL && stty -ixon

# History:
setopt SHARE_HISTORY		# Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS		# Do not record an event that was just recorded.
setopt HIST_IGNORE_ALL_DUPS	# Delete an old record even if a new event is duplicate.
setopt HIST_FIND_NO_DUPS	# Do not display a previously found event.
setopt HIST_IGNORE_SPACE	# Do not record an event starting with space.
setopt HIST_VERIFY		# Do not execute inmediately upon history expansion.

# Path to your oh-my-zsh installation.

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
  # history-substring-search
)

# Disable non end-of-line autosuggest accept widgets
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a89984,bg=#3c3836,underline,bold"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_left"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Git status while loading on large repos, was hard to see as grey
POWERLEVEL9K_VCS_LOADING_BACKGROUND="cyan"
POWERLEVEL9K_VCS_LOADING_FOREGROUND="black"

# Oh my zsh
source $ZSH/oh-my-zsh.sh

# Alises
source $ZDOTDIR/aliases/.aliasrc

# Enable accepting autosuggestions
bindkey '^O' forward-word
bindkey -v
bindkey '^ ' autosuggest-accept
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line)


# Solarized dir colors
eval `dircolors ~/.dircolors-gruvbox`
# eval `dircolors ~/dircolors-solarized`

# start ssh-agent with no output
eval `ssh-agent -s > /dev/null 2>&1`

# Use vi terminal mode
set -o vi

# Remove duplicates from environment variables
typeset -U PATH

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

neofetch
