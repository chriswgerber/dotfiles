#!/usr/bin/env zsh

(
  printf 'export GOROOT="%s/%s/libexec"' "$(dirname $go_prefix)" "$(readlink $go_prefix)"
  printf '\n'
) &> "${ZSH_CACHE_DIR}/go-env.sh"
