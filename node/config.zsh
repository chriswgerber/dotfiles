#!/usr/bin/env zsh

-dot-fpath-add "${DOTFILES_DIR}/node/functions"


export NVM_DIR="${HOME}/.nvm"

# Nodejs
-dot-path-add "${HOME}/.nodejs/bin"
-dot-path-add "${HOME}/Library/NodeJS/Versions/bin"
