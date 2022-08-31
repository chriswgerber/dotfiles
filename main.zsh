#!/bin/zsh

export DOTFILES_DIR=$(dirname $0)
# export DOT_CACHE_DIR="${DOTFILES_DIR}/.cache"
export DOT_CACHE_DIR="${HOME}/Library/Caches/com.chriswgerber.dotfiles"

export AZIMUTH_REPO_URL="https://github.com/ThatGerber/azimuth.git"

function init_azimuth() {
  # Azimuth Framework Library
  # -------------------------

  local _tmp \
    _azimuth="${1:=${DOT_CACHE_DIR}/azimuth}" \
    _repo_loc=${2:=${AZIMUTH_REPO_URL}}

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
