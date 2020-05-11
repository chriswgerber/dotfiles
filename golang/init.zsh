#!/usr/bin/env zsh

-dot-cache-source-file "go-env.sh"

-dot-add-path "$GOROOT/bin"

-dot-add-symlink-to-home "golang/dlv-config.yml" "$XDG_CONFIG_HOME/dlv/config.yml"
