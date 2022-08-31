#!/usr/bin/env zsh

-dot-symlink-update git/gitconfig .gitconfig
-dot-symlink-update git/gitk .gitk
-dot-symlink-update git/hub-config.toml $HUB_CONFIG

export_github_key
