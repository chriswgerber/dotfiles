#!/bin/zsh

(
  printf 'export PYENV_BREW_VERSION="%s";\n' \
    $(pyenv --version | awk '{print $2}')
) &> $(-dot-cache-get-file "pyenv-version.sh")

-dot-cache-update-file "pyenv.sh" "pyenv init - zsh"

(
  printf 'export PYENV_VIRTUALENV_VERSION="%s";\n' \
    $(ls "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/")
) &> $(-dot-cache-get-file "pyenv-venv-version.sh")

-dot-upgrade-completion poetry "${DOTFILES_DIR}/python/completions"
