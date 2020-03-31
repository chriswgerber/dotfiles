# Python

export PYTHONIOENCODING='utf8'

# Use Homebrew Python
-dot-add-path "${HOMEBREW_REPOSITORY}/opt/python/libexec/bin"

# Pyenv
PYENV_BREW_VERSION="${PYENV_BREW_VERSION:=}"

# Pyenv Virtualenv
export PYENV_VIRTUALENV_INIT=1;
export PYENV_VIRTUALENV_VERSION="${PYENV_VIRTUALENV_VERSION:=}"

# Virtualenv Cache
export PYENV_VIRTUALENV_CACHE_PATH="${XDG_CONFIG_HOME}/pyenv/virtualenv/cache"
export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=true

# PIP
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_DOWNLOAD_CACHE="${XDG_CONFIG_HOME}/pip/cache"
export PIP_CERT="${HOMEBREW_REPOSITORY}/etc/openssl@1.1/cert.pem"
