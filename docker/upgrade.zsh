#!/bin/zsh

_docker_comps_dir="${DOTFILES_DIR}/docker/completions"

( -dot-fpath-completion-update "kubectl" "completion" "zsh" "${_docker_comps_dir}" ) &
( -dot-fpath-completion-update "helm" "completion" "zsh" "${_docker_comps_dir}" ) &
( -dot-fpath-completion-update "eksctl" "completion" "zsh" "${_docker_comps_dir}" ) &

wait
