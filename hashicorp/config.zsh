#!/bin/zsh

# Vagrant
export VAGRANT_DEFAULT_PROVIDER="qemu"

# Packer
export PACKER_LOG_PATH="packer-log.txt"
export PACKER_LOG=0
export CHECKPOINT_DISABLE=1

# Terraform
export TF_LOG_PATH="terraform.log";
export TFENV_AUTO_INSTALL="true";
export TFENV_TERRAFORM_VERSION="1.10.2";
