# Enable proxy if Charles is running
if [[ "$(pgrep Charles)" != "" ]]; then
  proxy on
fi
