#!/usr/bin/env zsh

-dot-cache-read-file "go-env.sh"

-dot-symlink-update "golang/dlv-config.yml" "$XDG_CONFIG_HOME/dlv/config.yml"
