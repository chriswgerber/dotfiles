#!/bin/zsh

_py_comps_dir="${DOTFILES_DIR}/python/completions"
(poetry completions zsh) &> "${_py_comps_dir}/_poetry"

-dot-cache-update-file "pyenv.sh" "pyenv init - zsh"

(
  printf 'export PYENV_VIRTUALENV_VERSION="%s";\n' \
    $(ls "${HOMEBREW_REPOSITORY}/Cellar/pyenv-virtualenv/")
) &> $(-dot-cache-get-file "pyenv-venv-version.sh")
