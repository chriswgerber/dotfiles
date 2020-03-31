#!/bin/zsh

-dot-source-dotfile "${ZSH}/oh-my-zsh.sh" # Init OMZ

if test -n "${ZSH_DEBUG}"; then # Load ZSH profiling mod
    zmodload zsh/zprof
fi
