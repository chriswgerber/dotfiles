#!/bin/zsh

source "${HOMEBREW_PREFIX}/opt/awscli/libexec/bin/aws_zsh_completer.sh"


-dot-symlink-update aws/rds-combined-ca-bundle.pem ${AWS_HOME}/rds-combined-ca-bundle.pem
-dot-symlink-update aws/creds-vault ${AWS_HOME}/creds-vault


# CLI Aliases
-dot-github-repo-install "awslabs/awscli-aliases" "${AWS_CLI_ALIASES}"
test -L $AWS_HOME/cli/alias || ( \
  mkdir -p $AWS_HOME/cli;
  ln -s $AWS_CLI_ALIASES/alias $AWS_HOME/cli/alias;
)

# Decrypt AWS Config
# aws_decrypt_config $(dirname $(script_path $0))
