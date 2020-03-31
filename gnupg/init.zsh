-dot-add-symlink-to-home gnupg/gpg-agent.conf .gnupg/gpg-agent.conf
-dot-add-symlink-to-home gnupg/gpg.conf .gnupg/gpg.conf

if [[ -z "`pgrep gpg-agent`" ]]; then
  eval $(gpg-agent --daemon --log-file "${GPG_LOG_FILE}");
fi
