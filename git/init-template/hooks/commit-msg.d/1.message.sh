#!/bin/bash

commit_message=$1
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
TICKET_NAME=${BRANCH_NAME%%_*}

beginswith() { case $2 in "$1"*) true;; *) false;; esac; }

# Check if commit ID has string, and attempts to set ID from branch name.
if ! beginswith "$TICKET_NAME" "$commit_message"; then
  commit_message="$TICKET_NAME $COMMIT_MSG"
fi
