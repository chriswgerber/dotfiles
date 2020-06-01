#!/bin/zsh

-dot-upgrade-completion poetry "${DOTFILES_DIR}/python/completions"

-dot-cache-update-file "pyenv.sh" "pyenv init - zsh"

(
  printf 'export PYENV_VIRTUALENV_VERSION="%s";\n' \
    $(ls "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/")
) &> $(-dot-cache-get-file "pyenv-venv-version.sh")
