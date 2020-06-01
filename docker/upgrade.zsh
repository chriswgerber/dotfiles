#!/bin/zsh

_docker_comps_dir="${DOTFILES_DIR}/docker/completions"

-dot-upgrade-completion kubectl ${_docker_comps_dir} &
-dot-upgrade-completion helm ${_docker_comps_dir} &
-dot-upgrade-completion eksctl ${_docker_comps_dir} &

wait
