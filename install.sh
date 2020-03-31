#!/bin/bash

# Verify HOMEDIR is set and exists
# ======================================
if [[ -z $HOME ]] || [[ ! -d "$HOME" ]]; then
    echo '$HOME is not set or does not exist. $HOME must be set to install correctly.'
    return 1
fi

# Setup SSH Key
# ======================================
SSH_KEY=${SSH_KEY:-${HOME}/.ssh/id_rsa}
create_key="y"
if [ -f "${SSH_KEY}" ]; then
    read -rsp $'SSH_KEY already exists; Overwrite? [y/N].\n' -n1 skip_create_key
    if [[ "$skip_create_key" == "N" ]] || [[ "$skip_create_key" == "n" ]]; then
        create_key="N"
    fi
fi

if [[ "$create_key" != "N" ]] && [[ "$create_key" != "n" ]]; then
    echo "Creating SSH Key ${SSH_KEY}"
    mkdir -p "${HOME}/.ssh" && chmod 0700 "${HOME}/.ssh"
    ssh-keygen -t rsa -b 4096 -C '' -P '' -f "${SSH_KEY}"
fi
pbcopy <"${SSH_KEY}.pub"

# Add SSH Key to GitHub
# ======================================
echo 'Log into Github now and add your SSH key to the profile.'
read -rsp $'When you are done, press any key to continue.\n' -n1 GBG

# --- Install Xcode
if [[ "$(command -v git || xcode-select --install)" -ne 0 ]]; then
    read -rsp $'Installing Xcode Command Line Tools. When complete, press any key to continue.\n' -n1 GBG
fi

# --- Install Dotfiles
DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"
test -d "${DOTFILES_DIR}/.git" || git clone git@github.com:ThatGerber/dotfiles.git "${DOTFILES_DIR}"

git -C "${DOTFILES_DIR}" pull

# --- Setup ZSH
MAIN_ZSH="${MAIN_ZSH:-${DOTFILES_DIR}/main.zsh}"
test -f "$HOME/.zshrc" || (touch "$MAIN_ZSH" && (grep "source $MAIN_ZSH;" "$HOME/.zshrc" || (echo "source $MAIN_ZSH;" >"$HOME/.zshrc")))

PREF_SHELL=${PREF_SHELL:-/bin/zsh}

if [[ "$SHELL" != "$PREF_SHELL" ]]; then
    chsh -s "$PREF_SHELL" "$(whoami)"
fi

echo 'Setup is complete. Ready to install environment.'
read -rsp $'Press any key to continue.\n' -n1 GBG

# --- Run init and install env.
source $HOME/.zshrc

echo 'Installing Homebrew. Admin password will be required.'
read -rsp $'Press any key to continue.\n' -n1 GBG

# --- Install Homebrew packages.
command -v brew || exit 2
brew cask
brew bundle install --file="$DOTFILES_DIR/brew/Brewfile"
