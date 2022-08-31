# AWS

-dot-path-add "${DOTFILES_DIR}/aws/functions"
-dot-fpath-add "${DOTFILES_DIR}/aws/completions" "skip"

export AWS_HOME="$HOME/.aws"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_CONFIG_FILE="$AWS_HOME/config"
export AWS_SHARED_CREDENTIALS_FILE="$AWS_HOME/credentials"
export AWS_CLI_ALIASES="$DOT_CACHE_DIR/awscli-aliases"
export AWS_DEFAULT_OUTPUT="yaml"
export AWS_PAGER=""

# Only needed for this environment if ssl is broken
# export AWS_CA_BUNDLE=$CA_BUNDLE
