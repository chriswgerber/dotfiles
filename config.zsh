#!/bin/zsh

export MAIN_ZSH="${DOTFILES_DIR}/main.zsh"

# ZSH
# ======================================

export LANG=en_US.UTF-8 # Default Language
unsetopt autocd         # Disable AutoCD

export ZSH="${DOTFILES_DIR}/.cache/oh-my-zsh"
export ZSH_CUSTOM="${DOTFILES_DIR}/zsh_custom"
export ZSH_CACHE_DIR="${DOTFILES_DIR}/.cache"
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}/zcompdump"
export ZSH_DISABLE_COMPFIX=false # Warn about insecure autoload files
export DISABLE_AUTO_UPDATE=true


# Configs
# ======================================

export XDG_CONFIG_HOME="${HOME}/.config"

if [ -d $HOME/projects ]; then
    export PROJECTS="${HOME}/projects"
fi

case "$(ls /Users)" in
*cgerber)
  export DEFAULT_USER="cgerber"
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


# Themes
# --------------------------------------
# - agnoster
# - ys
# - Oxide https://github.com/dikiaap/dotfiles/blob/master/.oh-my-zsh/themes/oxide.zsh-theme
# - burgers (local)
ZSH_THEME="burgers"


# PLUGINS
# --------------------------------------
plugins=(colored-man-pages docker git golang gradle osx python)

# Remote plugins
-dot-install-github-plugin zsh-users/zsh-completions
-dot-install-github-plugin zsh-users/zsh-autosuggestions
-dot-install-github-plugin zsh-users/zsh-syntax-highlighting


# Install OMZ
# ======================================
-dot-install-omz

# Aliases
# ======================================

# Tree
alias tree="tree -C"

# Open `man` in preview
alias open-man="man-preview"

# Edit Hostsfile
alias edit_hosts="vim /etc/hosts"

# rsync_project - Rsyncs from local directory to destination, preserving user
alias rsync_project="rsync -rlptv --exclude '.*' --rsync-path=\"sudo -u saml rsync\" --delete ~/src dest:dir"

# ssh-by-file - SSH using a file.
alias ssh-by-file="ssh -F .ssh-config"

# Pretty JSON
alias prettyjson="python -m json.tool"
