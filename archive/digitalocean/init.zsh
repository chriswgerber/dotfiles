#!/bin/zsh

-dot-symlink-update digitalocean/doctlcfg ${DIGITALOCEAN_CONFIG_DIR}/config.yaml
chmod 0600 ${DIGITALOCEAN_CONFIG_DIR}/config.yaml
