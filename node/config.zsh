#!/usr/bin/env zsh

-dot-add-fpath "${DOTFILES_DIR}/node/functions"


export NVM_DIR="${HOME}/.nvm"

# Nodejs
-dot-add-path "${HOME}/.nodejs/bin"
-dot-add-path "${HOME}/Library/NodeJS/Versions/bin"
