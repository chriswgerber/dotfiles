#!/usr/bin/env bash

# Set API Keys and other Application Secrets
export ATOM_CONFIG_GIST_ACCESS_TOKEN=""
export RUBYGEMS_API_KEY=""
export EMAIL_ADDRESS="chriswgerber@gmail.com"

# Push Bullet
export PUSHBULLET_EMAIL=$EMAIL_ADDRESS
PUSHBULLET_API_KEY="$(-dot-keychain-get-value 'https://api.pushbullet.com/' ${PUSHBULLET_EMAIL})"
export PUSHBULLET_API_KEY

# Github Gist-only key
export GITHUB_USERNAME=$EMAIL_ADDRESS
GITHUB_GIST_KEY="$(-dot-keychain-get-value 'https://gist.github.com/' ${GITHUB_USERNAME})"
export GITHUB_GIST_KEY

# Gitlab Token, and it's many variations
export GITLAB_USERNAME=$EMAIL_ADDRESS
GITLAB_TOKEN="$(-dot-keychain-get-value 'https://gitlab.com/' ${GITLAB_USERNAME})"
export GITLAB_TOKEN
export GITLAB_API_TOKEN="$GITLAB_TOKEN"
export GITLAB_API_PRIVATE_TOKEN="$GITLAB_TOKEN"
