#!/bin/zsh

source $HOMEBREW_REPOSITORY/opt/awscli/libexec/bin/aws_zsh_completer.sh

-dot-add-symlink-to-home aws/rds-combined-ca-bundle.pem ${AWS_HOME}/rds-combined-ca-bundle.pem
-dot-add-symlink-to-home aws/creds-vault ${AWS_HOME}/creds-vault


# CLI Aliases
-dot-install-github-repo "awslabs/awscli-aliases" "${AWS_CLI_ALIASES}"
test -L $AWS_HOME/cli/alias || ln -s $AWS_CLI_ALIASES/alias $AWS_HOME/cli/alias


function _decrypted_aws() {
  ## Decrypt Config and Credentials to file
  local _cur_dir=$1

  local _enc_cred=$_cur_dir/credentials.asc _cred=$_cur_dir/credentials
  local _enc_conf=$_cur_dir/config.asc _conf=$_cur_dir/config

  if test $_enc_cred -nt $_cred; then
    echo 'Decrypting new AWS Credentials.'
    decrypt_verify "$_enc_cred"

    if ! test -s $_cred; then
      -dot-add-symlink-to-home ${_cred} .aws/credentials
    fi
  fi

  if test $_enc_conf -nt $_conf; then
    echo 'Decrypting new AWS Config.'
    decrypt_verify "$_enc_conf";

    if ! test -s $_conf; then
      -dot-add-symlink-to-home ${_conf} .aws/config
    fi
  fi
}

# _decrypted_aws $(dirname $(script_path $0))
