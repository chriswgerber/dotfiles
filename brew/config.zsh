# Homebrew

export HOMEBREW_REPOSITORY="$ZSH_CACHE_DIR/Homebrew"
export HOMEBREW_PREFIX="$HOME"
export HOMEBREW_CELLAR="${HOMEBREW_REPOSITORY}/Cellar"
export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications"

export HOMEBREW_INSTALL_BADGE="🦍"
export BREW_CLEANUP_PRUNE_DAYS=14
export BREW_FILE="${DOTFILES_DIR}/brew/Brewfile"

#######
# Paths

# Homebrew - Load as Preferred
-dot-add-path "${HOMEBREW_REPOSITORY}/bin"
-dot-add-path "${HOMEBREW_REPOSITORY}/sbin"

# Completions
fpath=($HOMEBREW_REPOSITORY/share/zsh/site-functions $fpath)
fpath=($HOMEBREW_REPOSITORY/share/zsh-completions $fpath)

# Openssl
-dot-add-path "${HOMEBREW_REPOSITORY}/opt/openssl@1.1/bin"

# Keybase
-dot-add-path "${HOME}/Applications/Keybase.app/Contents/SharedSupport/bin"
