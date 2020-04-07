# Enable proxy if Charles is running
if test -n "$(pgrep Charles)"; then
  proxy on
fi
