#!/bin/sh
CMD="pre-commit"
INSTALL_CMD="pip install $CMD --user"

if ! hash $CMD 2>/dev/null; then
  echo "pre-commit is not installed. Installing now: $INSTALL_CMD"
  eval $INSTALL_CMD
fi
