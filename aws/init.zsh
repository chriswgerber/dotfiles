#!/bin/zsh

-dot-add-symlink-to-home aws/rds-combined-ca-bundle.pem ${AWS_HOME}/rds-combined-ca-bundle.pem
-dot-add-symlink-to-home aws/creds-vault ${AWS_HOME}/creds-vault

source $HOMEBREW_REPOSITORY/opt/awscli/libexec/bin/aws_zsh_completer.sh

# CLI Aliases
-dot-install-github-repo "awslabs/awscli-aliases" "${AWS_CLI_ALIASES}"
test -L $AWS_HOME/cli/alias || (ln -s $AWS_CLI_ALIASES/alias $AWS_HOME/cli/alias);


# SCRIPT_DIR=$(dirname $(script_path $0))

# ENC_CREDF=$SCRIPT_DIR/credentials.asc
# CREDF=$SCRIPT_DIR/credentials
# if [ $ENC_CREDF -nt $CREDF ] || [ ! -s $CREDF ]; then
#   echo 'Decrypting new AWS Credentials.'
#   decrypt_verify "$ENC_CREDF";
# fi

# ENC_CONFF=$SCRIPT_DIR/config.asc
# CONFF=$SCRIPT_DIR/config
# if [ $ENC_CONFF -nt $CONFF ] || [ ! -s $CONFF ]; then
#   echo 'Decrypting new AWS Config.'
#   decrypt_verify "$ENC_CONFF";
# fi

# unset SCRIPT_DIR

# -dot-add-symlink-to-home aws/config .aws/config
# -dot-add-symlink-to-home aws/credentials .aws/credentials
