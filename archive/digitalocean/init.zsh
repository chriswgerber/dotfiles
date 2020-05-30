#!/bin/zsh

-dot-add-symlink-to-home digitalocean/doctlcfg ${DIGITALOCEAN_CONFIG_DIR}/config.yaml
chmod 0600 ${DIGITALOCEAN_CONFIG_DIR}/config.yaml
