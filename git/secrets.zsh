# GitLab & GitHub Secrets


# GitLab
export GITLAB_USERNAME="chriswgerber"
export GITLAB_REGISTRY="registry.gitlab.com"

export GITLAB_TOKEN="$(keychain_get_value ${GITLAB_REGISTRY} ${GITLAB_USERNAME})"
export GITLAB_API_TOKEN="$GITLAB_TOKEN"
export GITLAB_API_PRIVATE_TOKEN="$GITLAB_TOKEN"


# Github Gist-only key
_github_gist_url='https://gist.github.com/'
export GITHUB_USERNAME="ThatGerber"

export GITHUB_GIST_KEY="$(keychain_get_value ${_github_gist_url} ${GITHUB_USERNAME})"
