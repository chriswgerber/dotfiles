#!/bin/zsh

#
# Usage:
#     export ANSIBLE_SERVICE=my_team
#     export ANSIBLE_ACCOUNT=my_project
#
#     Can also check file defined in `VAULT_CFG` for service and account variables
#
#     Script checks executed/working dir for a file named by `VAULT_CFG_FILE`
#     (.vault_cfg)
#
#     script
#     script --vault-id 'id'
#
# To set a password, use:
#     script set [-r]
#         -r - Require system password every time to access stored value.
#

vault_cfg="$(pwd)/${VAULT_CFG_FILE}"

if test -r "${vault_cfg}"; then
  source "${vault_cfg}";
fi

# Generic group for passwords. Could group by org, team, or collection
ANSIBLE_SERVICE="${ANSIBLE_SERVICE:?}";
# Project/Playbook name.
ANSIBLE_ACCOUNT="${ANSIBLE_ACCOUNT:?}";

script_flags="-w"
script_flags+=" -s '${ANSIBLE_SERVICE}'"
script_flags+=" -a '${ANSIBLE_ACCOUNT}'"

case "$1" in
  "--vault-id*" )
    security find-generic-password ${script_flags} -j "${2}";
  ;;
  "set" )
    if [[ "$*" == *"-r"* ]]; then # Require password each time.
      script_flags+=" -T ''"
    fi
    security add-generic-password ${script_flags};
  ;;
  * )
    security find-generic-password ${script_flags};
  ;;
esac

exit
