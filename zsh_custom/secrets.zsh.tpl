#!/usr/bin/env bash

# Usage:
#
#    Set New Value:
#
#        keychain_set_value "URL" "USERNAME" "ADDL_ID"
#
#    You will be prompted to enter the value.
#
#    Retrieve Value:
#
#        keychain_get_value "URL" "USERNAME" "ADDL_ID"
#

# Set API Keys and other Application Secrets
export EMAIL_ADDRESS="chriswgerber@gmail.com"

# Push Bullet
export PUSHBULLET_EMAIL=$EMAIL_ADDRESS
PUSHBULLET_API_KEY="$(keychain_get_value 'https://api.pushbullet.com/' ${PUSHBULLET_EMAIL})"
export PUSHBULLET_API_KEY

# Github Gist-only key
export GITHUB_USERNAME=$EMAIL_ADDRESS
GITHUB_GIST_KEY="$(keychain_get_value 'https://gist.github.com/' ${GITHUB_USERNAME})"
export GITHUB_GIST_KEY

# Gitlab Token, and it's many variations
export GITLAB_USERNAME=$EMAIL_ADDRESS
GITLAB_TOKEN="$(keychain_get_value 'https://gitlab.com/' ${GITLAB_USERNAME})"
export GITLAB_TOKEN
export GITLAB_API_TOKEN="$GITLAB_TOKEN"
export GITLAB_API_PRIVATE_TOKEN="$GITLAB_TOKEN"
