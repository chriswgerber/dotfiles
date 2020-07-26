#!/bin/zsh

export ZSH_DEBUG=1

export MAIN_ZSH="${DOTFILES_DIR}/main.zsh"
export GIT_PROTOCOL="https"

export LANG=en_US.UTF-8 # Default Language
unsetopt autocd         # Disable AutoCD

# ZSH
# ======================================
export DOT_CACHE_DIR="${DOTFILES_DIR}/.cache"
export ZSH="${DOT_CACHE_DIR}/oh-my-zsh"
export ZSH_CACHE_DIR="${DOT_CACHE_DIR}"
export ZSH_CUSTOM="${ZSH_CACHE_DIR}/zsh_custom"
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}/zcompdump"

export ZSH_DISABLE_COMPFIX=false # Warn about insecure autoload files
export DISABLE_AUTO_UPDATE=true


# Configs
# ======================================

export XDG_CONFIG_HOME="${HOME}/.config"

if [ -d $HOME/projects ]; then
    export PROJECTS="${HOME}/Projects"
fi

case "$(ls /Users)" in
*cgerber)
  export DEFAULT_USER="cgerber"
  ;;
*cgerber2)
  export DEFAULT_USER='cgerber2'
  ;;
*chriswgerber)
  export DEFAULT_USER='chriswgerber'
  ;;
*)
  unset DEFAULT_USER
  ;;
esac


# Load system and user paths
# ======================================
export PATH="/bin"
-dot-add-path "/sbin"
-dot-add-path "/usr/bin"
-dot-add-path "/usr/sbin"
-dot-add-path "/usr/local/bin"
-dot-add-path "/usr/local/sbin"
-dot-add-path "$HOME/bin"
# Load Manpaths
export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="$HOME/share/man:$MANPATH"


# Install OMZ
# ======================================
-dot-install-omz


# Themes
# --------------------------------------
# - agnoster
# - ys
# - Oxide https://github.com/dikiaap/dotfiles/blob/master/.oh-my-zsh/themes/oxide.zsh-theme
# - burgers (local)
ZSH_THEME=""


# PLUGINS
# --------------------------------------
plugins=(
  colored-man-pages
  docker
  git
  github
  golang
  gradle
  iterm2
  keychain
  osx
  python
  terraform
)

# Remote plugins
-dot-install-github-plugin zsh-users/zsh-completions
-dot-install-github-plugin zsh-users/zsh-autosuggestions
-dot-install-github-plugin zsh-users/zsh-syntax-highlighting


# Upgrade Ignore
# --------------------------------------
# Directories in cache to ignore during upgrade.
DOT_UPGRADE_IGNORE=(
  Homebrew
  oh-my-zsh
  zsh_custom
)
export DOT_UPGRADE_IGNORE
