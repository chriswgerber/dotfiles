#!/bin/bash

_aws_user=$1
_aws_profile=$2

_cur_access_key=$(aws configure get aws_access_key_id --output text --profile "$_aws_profile")
_tmp_file=$(mktemp)

(
    echo "Creating new IAM Credentials"
    aws iam create-access-key --profile "$_aws_profile" --user-name "$_aws_user" >"$_tmp_file"

    echo "Marking previous key inactive"
    aws iam update-access-key \
        --access-key-id "$_cur_access_key" \
        --user-name "$_aws_user" \
        --status Inactive \
        --profile "$_aws_profile"

    echo "Setting new access key"
    aws configure set aws_access_key_id "$(jq -r '.AccessKey.AccessKeyId' $_tmp_file)" --profile "$_aws_profile"

    echo "Setting new secret key"
    aws configure set aws_secret_access_key "$(jq -r '.AccessKey.SecretAccessKey' $_tmp_file)" --profile "$_aws_profile"
)

rm "$_tmp_file"
