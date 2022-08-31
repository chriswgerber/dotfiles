# Homebrew

-dot-fpath-add "${DOTFILES_DIR}/brew/functions"


export HOMEBREW_PREFIX="/usr/local"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
# export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Applications"


export HOMEBREW_INSTALL_BADGE="🦍"
export BREW_CLEANUP_PRUNE_DAYS=14
export BREW_FILE="${DOTFILES_DIR}/brew/Brewfile"


#######
# Paths

-dot-path-add "${HOMEBREW_PREFIX}/bin"
-dot-path-add "${HOMEBREW_PREFIX}/sbin"

export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/usr/local/share/info:${INFOPATH:-}";

# Completions
fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)
fpath=("${HOMEBREW_PREFIX}/share/zsh-completions" $fpath)

# Openssl
-dot-path-add "${HOMEBREW_PREFIX}/opt/openssl@1.1/bin"

# Keybase
-dot-path-add "${HOME}/Applications/Keybase.app/Contents/SharedSupport/bin"
