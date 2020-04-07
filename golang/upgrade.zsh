#!/bin/zsh

(
  go_prefix="$(brew --prefix go)"
  printf 'export GOROOT="%s/%s/libexec"\n' \
    "$(dirname $go_prefix)" \
    "$(readlink $go_prefix)"
) &> "${ZSH_CACHE_DIR}/go-env.sh"
