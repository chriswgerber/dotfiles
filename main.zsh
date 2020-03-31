#!/bin/zsh

# Azimuth Framework Library
# --------------------------------------
export DOTFILES_DIR=$(dirname $0)
export AZIMUTH_DIR="${DOTFILES_DIR}/.cache/azimuth"

if ! test -d "${AZIMUTH_DIR}"; then
  mkdir -p ${AZIMUTH_DIR};
  git clone git@github.com:ThatGerber/azimuth.git ${AZIMUTH_DIR};
fi

source "${AZIMUTH_DIR}/main.zsh"

# Main
-dot-main
