#!/usr/bin/env zsh

{
  printf 'pyenv init - zsh'
  printf "\n"
} &> "${ZSH_CACHE_DIR}/pyenv.sh"

{
  printf 'export PYENV_VIRTUALENV_VERSION="%s"' $(ls "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/")
  printf "\n";
} &> "${ZSH_CACHE_DIR}/pyenv-venv-version.sh"


( poetry completions zsh &> "${DOTFILES_DIR}/python/completions/_poetry" )
