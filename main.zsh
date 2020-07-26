#!/bin/zsh

export DOTFILES_DIR=$(dirname $0)

function init_azimuth() {
  # Azimuth Framework Library
  # -------------------------

  local _tmp \
    _repo_loc="https://github.com/ThatGerber/azimuth.git" \
    _azimuth="${1:=${DOTFILES_DIR}/.cache/azimuth}"

  if ! test -d "${_azimuth}"; then
    mkdir -p "$(dirname ${_azimuth})";
    _tmp=$(git -C "${_azimuth}" remote -v &>/dev/null)
    if test $? -ne 0; then
      git clone "${_repo_loc}" ${_azimuth};
    fi
  fi

  printf "%s" "${_azimuth}"
}

# Main
source "$(init_azimuth)/main.zsh"

-dot-main ${DOTFILES_DIR}
