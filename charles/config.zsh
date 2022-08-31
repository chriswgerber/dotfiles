# Charles

-dot-fpath-add "${DOTFILES_DIR}/charles/functions"

# Envs:
# CHARLES_PORT
# CHARLES_PROXY
# CHARLES_NO_PROXY

export CHARLES_PROXY="http://127.0.0.1:${CHARLES_PORT:-8888}"
export CHARLES_NO_PROXY="" # "localhost,.local,169.254.,127.0.0.1,10.0.2.,/var/run/docker.sock"
