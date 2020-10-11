# Environmetal variables are set here.

# Default programs:
# Editor
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="kitty"
export BROWSER="chrome"
export WM="awesomewm"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"	# History filepath
export HISTSIZE=1000			# Maximum events for internal history
export SAVEHIST=1000			# Maximum events in history file

# X11
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/xinitrc"

