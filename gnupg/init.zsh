-dot-add-symlink-to-home gnupg/gpg-agent.conf .gnupg/gpg-agent.conf
-dot-add-symlink-to-home gnupg/gpg.conf .gnupg/gpg.conf

if test -z "$(pgrep gpg-agent)" -a -n $(command -v gpg-agent); then
  (gpg-agent --daemon --log-file "${GPG_LOG_FILE}") 1>/dev/null
fi
