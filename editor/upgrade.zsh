#!/bin/zsh

(
  printf 'export VIMRUNTIME="%s/share/vim/vim%s";\n' \
      "${HOMEBREW_PREFIX}" \
      "$(vim --version | grep "Vi IMproved" | awk '{print $5}' | tr -d '.')"
) &> $(-dot-cache-create-file vim.sh)
