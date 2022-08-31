#!/usr/bin/env zsh

test -d $PYENV_VIRTUALENV_CACHE_PATH || mkdir -p $PYENV_VIRTUALENV_CACHE_PATH

-dot-symlink-update python/pip.conf .config/pip/pip.conf
-dot-symlink-update python/pydistutils.cfg .pydistutils.cfg

-dot-cache-read-file "pyenv-version.sh"

-dot-file-source "pyenv.zsh" "${HOMEBREW_CELLAR}/pyenv/${PYENV_BREW_VERSION}/completions"

-dot-cache-read-file "pyenv-venv-version.sh"
-dot-cache-read-file "pyenv.sh"

-dot-path-add "${HOMEBREW_CELLAR}/pyenv-virtualenv/${PYENV_VIRTUALENV_VERSION}/shims"

typeset -g -a precmd_functions

if test -z "${precmd_functions[_pyenv_virtualenv_hook]}"; then
  precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
fi
