#!/usr/bin/env zsh

test -d $PYENV_VIRTUALENV_CACHE_PATH || mkdir -p $PYENV_VIRTUALENV_CACHE_PATH

-dot-add-symlink-to-home python/pip.conf .config/pip/pip.conf
-dot-add-symlink-to-home python/pydistutils.cfg .pydistutils.cfg

-dot-cache-source-file "pyenv-version.sh"

-dot-source-dotfile "pyenv.zsh" "${HOMEBREW_CELLAR}/pyenv/${PYENV_BREW_VERSION}/completions"

-dot-cache-source-file "pyenv-venv-version.sh"
-dot-cache-source-file "pyenv.sh"

-dot-add-path "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/${PYENV_VIRTUALENV_VERSION}/shims"

typeset -g -a precmd_functions

if test -z "${precmd_functions[_pyenv_virtualenv_hook]}"; then
  precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
fi
