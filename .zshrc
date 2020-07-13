# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
)

source $ZSH/oh-my-zsh.sh

alias open="xdg-open"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pipes='pipes.sh -t 3 -r 0'
alias diff="kitty +kitten diff"

eval `dircolors ~/.dircolors`
eval `ssh-agent -s > /dev/null 2>&1`

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_left"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Git status while loading on large repos, was hard to see as grey
POWERLEVEL9K_VCS_LOADING_BACKGROUND="cyan"
POWERLEVEL9K_VCS_LOADING_FOREGROUND="black"

# Use vi terminal mode
set -o vi

source /usr/share/nvm/init-nvm.sh

neofetch
