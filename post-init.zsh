# Post Init

test -s "${SDKMAN_DIR}/bin/sdkman-init.sh" && \
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"

promptinit
prompt dotfiles
