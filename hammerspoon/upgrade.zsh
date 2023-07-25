#!/bin/zsh

# Move hs config dir to dotfiles dir
defaults write org.hammerspoon.Hammerspoon MJConfigFile "${HS_CONFIG_DIR}/init.lua"
