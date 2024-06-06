#!/bin/zsh

autoload -Uz compinit
compinit

# Init OMZ
-dot-file-source "${ZSH}/oh-my-zsh.sh"

autoload -Uz promptinit
autoload -U add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

# Load ZSH profiling mod
if test -n "${ZSH_DEBUG}"; then
    zmodload zsh/zprof
fi
