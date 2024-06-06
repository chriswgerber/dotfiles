#!/bin/bash

function _run_precommit() {
  local PC_YAML=.pre-commit-config.yaml
  local PC_DEFAULT_YAML=.git/etc/pre-commit-config.yaml

  if [[ ! -f ${PC_YAML} ]]; then
    echo "Creating pre-commit config file, because one doesn't exist.";
    cp ${PC_DEFAULT_YAML} ${PC_YAML};
    echo "Adding ${PC_YAML} to repository.";
    git add ${PC_YAML}
  fi

  # $(git config --path --get init.templatedir)/../scripts/install-pre-commit.sh

  if [[ -f ${PC_YAML} ]]; then pre-commit; fi
}
