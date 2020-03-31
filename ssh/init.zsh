-dot-add-symlink-to-home ssh/config .ssh/config
-dot-add-symlink-to-home ssh/config-template .ssh/config-template

(
  if [[ -z "`pgrep ssh-agent`" ]]; then
    eval $(ssh-agent)
    ssh-add
  fi
) 1>&/dev/null
