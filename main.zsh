#!/bin/zsh

export DOTFILES_DIR=$(dirname $0);
export AZIMUTH_REPO_URL="https://github.com/ThatGerber/azimuth.git";

# I wish I could get this dynamically since it is declared later, but I can't.
export DOT_CACHE_DIR="${HOME}/Library/Caches/com.chriswgerber.dotfiles";


function bootstrap_azimuth() {
  # Azimuth Framework Library
  # -------------------------
  local _tmp;
  local _azimuth="${1:=${DOT_CACHE_DIR}/azimuth}";
  local _repo_loc=${2:=${AZIMUTH_REPO_URL}};

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
source "$(bootstrap_azimuth)/main.zsh";


function -dot-omz-load-plugin() {
  # Loads OMZ plugin file and any completions.
  local _plgn_name="${1}";
  local _plgn_dir="${ZSH}/plugins/${_plgn_name}";
  local _custom_plgn_dir="${ZSH_CUSTOM}/plugins/${_plgn_name}";
  local _plgn_filename="${_plgn_name}.plugin.zsh";
  local _plgn_file;

  # Load plugin files
  if test -d "${_custom_plgn_dir}"; then
    local _plgn_file="${_custom_plgn_dir}/${_plgn_filename}";

  elif test -d "${_plgn_dir}"; then
    local _plgn_file="${_plgn_dir}/${_plgn_filename}";

  fi

  source "${_plgn_file}";
}


-dot-main ${DOTFILES_DIR};
