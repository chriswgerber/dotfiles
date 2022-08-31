#!/bin/zsh

_docker_comps_dir="${DOTFILES_DIR}/docker/completions"

( -dot-upgrade-completion "kubectl" "completion" "zsh" "${_docker_comps_dir}" ) &
( -dot-upgrade-completion "helm" "completion" "zsh" "${_docker_comps_dir}" ) &
( -dot-upgrade-completion "eksctl" "completion" "zsh" "${_docker_comps_dir}" ) &

wait
