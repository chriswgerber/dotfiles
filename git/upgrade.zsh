#!/usr/bin/env zsh

(test -n "${GITHUB_GIST_KEY}" && echo "${GITHUB_GIST_KEY}") &> "$HOME/.gist"
