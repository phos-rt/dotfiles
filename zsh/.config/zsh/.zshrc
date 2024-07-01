fpath=("$ZDOTDIR"/prompts $fpath)

source "$ZDOTDIR"/alias

# bindings
bindkey '^R' history-incremental-search-backward

# completion system... it ain't working yet
autoload -U compinit; compinit

# TODO(phos): on gentoo this should run but not on void,
# could do that by hostname I guess
if false; then
	autoload -U promptinit
	prompinit; prompt gentoo
fi

# prompt
autoload -Uz prompt_purification_setup; prompt_purification_setup

setopt AUTO_PUSHD        # push the current dir to the stack
setopt PUSHD_IGNORE_DUPS # ignore duplicates
setopt PUSHD_SILENT      # dont print directory on pushd and popd

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

# opam configuration
[[ ! -r /home/phos/.opam/opam-init/init.zsh ]] || source /home/phos/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# vim mode
bindkey -v
bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward
