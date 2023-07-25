#!/usr/bin/env zsh

-dot-path-add "$DOTFILES_DIR/vscode/bin"
-dot-path-add "${HOME}/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# VS Code Config
export VSCODE_CONFIG_DIR="${HOME}/Library/Application Support/Code/User"
export VSCODE_EXT_FILE="${DOTFILES_DIR}/vscode/VSCodeExtensions.txt"
