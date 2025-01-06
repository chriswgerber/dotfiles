# Charles

-dot-path-add "/Applications/Charles.app/Contents/MacOS"

-dot-fpath-add "${DOTFILES_DIR}/charles/functions"

# Envs:
# CHARLES_PORT
# CHARLES_PROXY
# CHARLES_NO_PROXY
CHARLES_HOST="127.0.0.1"
export CHARLES_PROXY="http://${CHARLES_HOST}:${CHARLES_PORT:-8888}"
export CHARLES_NO_PROXY="" # "localhost,.local,169.254.,127.0.0.1,10.0.2.,/var/run/docker.sock"
