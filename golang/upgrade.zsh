#!/bin/zsh

(
  _go_prefix="$(brew --prefix go)"
  printf 'export GOROOT="%s/%s/libexec";\n' \
      "$(dirname $_go_prefix)" \
      "$(readlink $_go_prefix)"
  echo '-dot-path-add "$GOROOT/bin";'
) &> $(-dot-cache-get-file "go-env.sh")
