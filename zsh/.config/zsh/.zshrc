fpath=("$ZDOTDIR"/prompts $fpath)

source "$ZDOTDIR"/alias

# bindings
bindkey '^R' history-incremental-search-backward

# completion system... it ain't working yet
autoload -U compinit; compinit

# prompt
autoload -Uz prompt_purification_setup; prompt_purification_setup

setopt AUTO_PUSHD        # push the current dir to the stack
setopt PUSHD_IGNORE_DUPS # ignore duplicates
setopt PUSHD_SILENT      # dont print directory on pushd and popd

# zellij autostart on shell creation
if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

# set up gpg agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# source non-public files
if [[ -d "$ZDOTDIR" ]]; then
  for file in "$ZDOTDIR"/private/*; do
    source "$file"
  done
fi
