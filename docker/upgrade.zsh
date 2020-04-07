#!/bin/zsh

( kubectl completion zsh &> "${DOTFILES_DIR}/docker/completions/_kubectl" ) &
( helm completion zsh &> "${DOTFILES_DIR}/docker/completions/_helm" ) &
( eksctl completion zsh &> "${DOTFILES_DIR}/docker/completions/_eksctl" ) &

wait
