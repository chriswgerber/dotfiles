#!/bin/zsh

export DOTFILES_DIR=$(dirname $0)

# Azimuth Framework Library
# --------------------------------------
azimuth_dir="${DOTFILES_DIR}/.cache/azimuth"

if ! test -d "${azimuth_dir}"; then
  mkdir -p "$(dirname ${azimuth_dir})";
  __d=$(git -C "${azimuth_dir}" remote -v &>/dev/null)
  if test $? -ne 0; then
    git clone https://github.com/ThatGerber/azimuth.git ${azimuth_dir};
  fi
  unset __d
fi


# Main
source "${azimuth_dir}/main.zsh"
-dot-main ${DOTFILES_DIR}
