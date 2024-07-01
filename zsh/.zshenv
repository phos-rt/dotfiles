# sets up the base directory for zsh inside XDG_CONFIG_HOME instead of HOME
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# configure stuff about the history
export HISTFILE="$ZDOTDIR/.zhistory" # history path
export HISTSIZE=10000                # maximum events for internal history
export SAVEHIST=10000                # maximum events in history file

# configure path for local binaries
export PATH="$HOME/.local/bin:$PATH"

# configure default editors
export EDITOR=nvim
export VISUAL=nvim
