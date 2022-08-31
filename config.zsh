#!/bin/zsh

export ZSH_DEBUG=1

export MAIN_ZSH="${DOTFILES_DIR}/main.zsh"
export GIT_PROTOCOL="https"

export LANG=en_US.UTF-8 # Default Language
unsetopt autocd         # Disable AutoCD
setopt HIST_IGNORE_SPACE # ignore commands with a space at the beginning

# ZSH
# ======================================
export DOT_CACHE_DIR="${DOT_CACHE_DIR:=${DOTFILES_DIR}/.cache}"
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
-dot-path-add "/sbin"
-dot-path-add "/usr/bin"
-dot-path-add "/usr/sbin"
-dot-path-add "/usr/local/bin"
-dot-path-add "/usr/local/sbin"
-dot-path-add "$HOME/bin"
# Load Manpaths
export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="$HOME/share/man:$MANPATH"


# Install OMZ
# ======================================
-dot-omz-install


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
  macos
  python
  terraform
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  mac-zsh-completions
)

# Remote plugins
-dot-github-plugin-add zsh-users/zsh-completions
-dot-github-plugin-add zsh-users/zsh-autosuggestions
-dot-github-plugin-add zsh-users/zsh-syntax-highlighting
-dot-github-plugin-add scriptingosx/mac-zsh-completions

# Upgrade Ignore
# --------------------------------------
# Directories in cache to ignore during upgrade.
export DOT_UPGRADE_IGNORE=(
  azimuth
  Hasklig
  Homebrew
  oh-my-zsh
  zsh_custom
)

# Computer information
DEFAULT_MONITOR_ID="FD273083-6A62-CF50-AFE5-7C7619EAF5E5"
