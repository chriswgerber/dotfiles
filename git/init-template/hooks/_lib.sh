#!/bin/zsh


GIT_REPO_HOOKS_DIR="$(dirname "${0}")";


run_hooks_d() {
  local exit_code;
  local hook_dir;
  local stdin;
  local script_dir="${GIT_REPO_HOOKS_DIR}";
  local hook_name="${GIT_REPO_HOOK_NAME:-""}";

  hook_dir="${script_dir}/$hook_name.d";

  printf "=> Loading\t[%s]\t:\n" "$(basename ${hook_dir})";

  if test -d "$hook_dir"; then
    stdin=$(cat /dev/stdin);

    for hook in "$hook_dir/"*; do
      printf '=> Executing\t[%s]\t: %s\n' "${hook_name}" "$(basename ${hook})";
      echo "$stdin" | "${hook}" "$@";

      exit_code=$?;

      if test "${exit_code}" -ne 0; then
        exit "${exit_code}";
      fi
    done
  fi

  exit 0;
}
