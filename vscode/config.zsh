#!/usr/bin/env zsh

-dot-path-add "$DOTFILES_DIR/vscode/bin"
-dot-path-add "${HOME}/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# VS Code Config
export VSCODE_EXT_FILE="${DOTFILES_DIR}/vscode/VSCodeExtensions.txt"
