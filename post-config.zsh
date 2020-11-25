#!/bin/zsh

-dot-source-dotfile "${ZSH}/oh-my-zsh.sh" # Init OMZ

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

# rsync_project - Rsyncs from local directory to destination, preserving user
alias rsync-project="rsync -rlptv --exclude '.*' --rsync-path=\"sudo -u saml rsync\" --delete ~/src dest:dir"

# ssh-by-file - SSH using a file.
alias ssh-by-file="ssh -F .ssh-config"

# Pretty JSON
alias prettyjson="python -m json.tool"

# Remove slash from gradlew
alias gradlew="./gradlew"
