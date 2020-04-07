#!/bin/zsh

# Golang
export GOPATH=$HOME/Projects
export GOBIN=$HOME/bin

# Add to Path
-dot-add-path "${GOBIN}"

# Config
export GO111MODULE=on
