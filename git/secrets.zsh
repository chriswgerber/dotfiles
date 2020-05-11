# GitLab & GitHub Secrets


# GitLab
export GITLAB_USERNAME="thatgerber"
export GITLAB_URL="https://gitlab.com/"
export GITLAB_REGISTRY="registry.gitlab.com"

function export_gitlab_token() {
  export GITLAB_TOKEN="$(keychain_get_value ${GITLAB_URL} ${GITLAB_USERNAME})"
  export GITLAB_API_TOKEN="$GITLAB_TOKEN"
  export GITLAB_API_PRIVATE_TOKEN="$GITLAB_TOKEN"
}
# export_gitlab_token


# Github Gist-only key
export GITHUB_USERNAME="thatgerber"

function export_gitlab_gist_key() {
  local github_gist_url='https://gist.github.com/'

  export GITHUB_GIST_KEY="$(keychain_get_value ${github_gist_url} ${GITHUB_USERNAME})"
}
# export_gitlab_gist_key
