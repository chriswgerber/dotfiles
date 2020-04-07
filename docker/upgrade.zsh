#!/bin/zsh

_docker_comps_dir="${DOTFILES_DIR}/docker/completions"

( kubectl completion zsh &> "${_docker_comps_dir}/_kubectl" ) &
( helm completion zsh &> "${_docker_comps_dir}/_helm" ) &
( eksctl completion zsh &> "${_docker_comps_dir}/_eksctl" ) &

wait
