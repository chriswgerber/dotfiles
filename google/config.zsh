#!/bin/zsh

# Google Cloud SDK Config
export GCLOUDSDKPATH="${HOMEBREW_REPOSITORY}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

test -r "${GCLOUDSDKPATH}/path.zsh.inc" &&
  source "${GCLOUDSDKPATH}/path.zsh.inc";
test -r "${GCLOUDSDKPATH}/completion.zsh.inc" &&
  source "${GCLOUDSDKPATH}/completion.zsh.inc";
