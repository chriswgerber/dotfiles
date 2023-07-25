# Git

-dot-fpath-add "${DOTFILES_DIR}/git/functions"

export PR_CHECKOUT_DIR="${XDG_DATA_HOME}/${BUNDLE_ID}/pull-requests"


# Github
# --------------------------------------
export \
  HUB_CONFIG="$XDG_CONFIG_HOME/hub" \
  GITHUB_GIST_URL="https://gist.github.com/" \
  GITHUB_SCHEME="https://" \
  GITHUB_HOST="github.com" \
  GITHUB_USER="chriswgerber" \
  GITHUB_USERNAME="${GITHUB_USERNAME}"


# GitLab
# --------------------------------------
export \
  GITLAB_USERNAME="thatgerber" \
  GITLAB_URL="https://gitlab.com/" \
  GITLAB_REGISTRY="registry.gitlab.com"
