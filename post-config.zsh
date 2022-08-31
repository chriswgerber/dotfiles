#!/bin/zsh

-dot-file-source "${ZSH}/oh-my-zsh.sh" # Init OMZ

if test -n "${ZSH_DEBUG}"; then # Load ZSH profiling mod
    zmodload zsh/zprof
fi


# Aliases
# ======================================

# Old Shell Upgrade Command
alias -- -upgrade-shell-env="-dot-upgrade-shell-env"

# Tree
alias tree="tree -C"

# Edit Hostsfile
alias edit-hosts="vim /etc/hosts"

# ssh-by-file - SSH using a file.
alias ssh-by-file="ssh -F .ssh-config"

# Pretty JSON
alias prettyjson="python -m json.tool"

# Remove slash from gradlew
alias gradlew="./gradlew"
