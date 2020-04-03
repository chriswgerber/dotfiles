#!/bin/zsh

(poetry completions zsh) &> "${DOTFILES_DIR}/python/completions/_poetry"

(pyenv init - zsh) &> "${ZSH_CACHE_DIR}/pyenv.sh"

{
  printf 'export PYENV_VIRTUALENV_VERSION="%s"\n' \
    $(ls "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/");
} &> "${ZSH_CACHE_DIR}/pyenv-venv-version.sh"
