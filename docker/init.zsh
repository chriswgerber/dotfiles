#!/bin/zsh

-dot-symlink-update docker/config.json .docker/config.json


test -d ~/.docker/cli-plugins || (
  mkdir -p ~/.docker/cli-plugins;
  test -x ${HOMEBREW_PREFIX}/opt/docker-buildx/bin/docker-buildx && (
    test -l ~/.docker/cli-plugins/docker-buildx ||
      ln -sfn ${HOMEBREW_PREFIX}/opt/docker-buildx/bin/docker-buildx \
        ~/.docker/cli-plugins/docker-buildx;
  )
)
