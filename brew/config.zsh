# Homebrew

-dot-fpath-add "${DOTFILES_DIR}/brew/functions"

if [[ "$(uname -p)" == "arm" ]]; then
  # M1 macs
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
else
  # Intel macs
  export HOMEBREW_PREFIX="/usr/local"
  export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
fi

export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"

# Use to attempt to force apps as user installs.
# export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications"

export HOMEBREW_INSTALL_BADGE="🦍"
export BREW_CLEANUP_PRUNE_DAYS=14
export BREW_FILE="${DOTFILES_DIR}/brew/Brewfile"


#######
# Paths
-dot-path-add "${HOMEBREW_PREFIX}/bin"
-dot-path-add "${HOMEBREW_PREFIX}/sbin"

export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

# Completions
fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
fpath=("${HOMEBREW_PREFIX}/share/zsh-completions" $fpath)

# Openssl
-dot-path-add "${HOMEBREW_PREFIX}/opt/openssl@1.1/bin"

# Keybase
-dot-path-add "${HOME}/Applications/Keybase.app/Contents/SharedSupport/bin"
