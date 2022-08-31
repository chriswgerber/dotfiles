#!/bin/zsh

-dot-fpath-add "${DOTFILES_DIR}/google/functions"


# Google Cloud SDK Config
export GCLOUDSDKPATH="${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

test -r "${GCLOUDSDKPATH}/path.zsh.inc" &&
  source "${GCLOUDSDKPATH}/path.zsh.inc";
test -r "${GCLOUDSDKPATH}/completion.zsh.inc" &&
  source "${GCLOUDSDKPATH}/completion.zsh.inc";
