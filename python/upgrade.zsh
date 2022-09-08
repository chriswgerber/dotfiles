#!/bin/zsh

(
  printf 'export PYENV_BREW_VERSION="%s";\n' \
    $(pyenv --version | awk '{print $2}')
) &> $(-dot-cache-create-file "pyenv-version.sh")

-dot-cache-update-file "pyenv.sh" "pyenv init - zsh"

(
  printf 'export PYENV_VIRTUALENV_VERSION="%s";\n' \
    $(ls "${HOMEBREW_CELLAR}/pyenv-virtualenv/")
) &> $(-dot-cache-create-file "pyenv-venv-version.sh")

( -dot-fpath-completion-update poetry completions zsh "${DOTFILES_DIR}/python/completions" ) &

wait
