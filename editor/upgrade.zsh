#!/usr/bin/env zsh

{
  printf 'export VIMRUNTIME="%s/share/vim/vim%s"\n' \
    "${HOMEBREW_REPOSITORY}" \
    $(vim --version | grep "Vi IMproved" | awk '{print $5}' | tr -d '.')
} &> "${ZSH_CACHE_DIR}/vim.sh"
