# GnuPG

# Default GPG Key
export DEFAULT_PGP_KEY="0x56CC6498381FD53F"
export PGP_KEY_ID="0x56CC6498381FD53F"

# export SSH_KEY_PATH="$HOME/.ssh/id_rsa"
export GPGHOME=$HOME/.gnupg
export GPG_LOG_FILE="${GPGHOME}/gpg-agent.log"

# SSH Auth Socket
export SSH_AUTH_SOCK=$GPGHOME/S.gpg-agent.ssh

# Use Curses for Pinentry
export GPG_TTY=$(tty)

# GPG2.2 and encfs
export FUSE_INCLUDE_DIR=/usr/local/include
export FUSE_LIBRARIES=/usr/local/lib
