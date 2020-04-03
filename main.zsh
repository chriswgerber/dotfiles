#!/bin/zsh

# Azimuth Framework Library
# --------------------------------------
export DOTFILES_DIR=$(dirname $0)

azimuth_dir="${DOTFILES_DIR}/.cache/azimuth"

if ! test -d "${azimuth_dir}"; then
  mkdir -p "$(dirname ${azimuth_dir})";

  __dir=$(git -C "${azimuth_dir}" remote -v &>/dev/null)
  if test $? -ne 0; then
    git clone https://github.com/ThatGerber/azimuth.git ${azimuth_dir};
  fi
fi

# Main
source "${azimuth_dir}/main.zsh"
-dot-main
