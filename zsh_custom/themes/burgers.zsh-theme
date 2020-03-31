#!/usr/bin/env zsh
# Burgers theme for Oh My Zsh
# License: MIT

autoload -U add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst

function burgers_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}

function burgers_chpwd {
    PR_GIT_UPDATE=1
}

function burgers_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't.
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="on %{$turquoise%} %b%u%c%{$red%} ● %{$PR_RST%}"
        else
            FMT_BRANCH="on %{$turquoise%} %b%u%c%{$PR_RST%}"
        fi

        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}

function burgers_prompt_path {
    echo "%{$green%}%~${PR_RST} "
}

function burgers_prompt_vcs {
    echo "$vcs_info_msg_0_"
}

function burgers_prompt_pyenv() {
    [ "$(pyenv version-name)" != "system" ] &&
      echo "%{$blue%}pyenv:$(pyenv version-name)%{$PR_RST%} "
}

function burgers_prompt_aws {
    local _prompt_profile

    _prompt_profile=$AWS_DEFAULT_PROFILE

    (test -n $AWS_PROFILE && _prompt_profile=$AWS_PROFILE) || true
    [ "$_prompt_profile" ] && echo "%{$orange%}aws:%U$_prompt_profile%u%{$PR_RST%} "
}

function burgers_prompt_exitcode {
    echo "%{$red%}%(?..C:%?)%{$PR_RST%}"
}

function burgers_prompt_symbol {
    echo "%(?.%F{white}.%F{red})${PROMPT_SYMBOL}"
}

function burgers_prompt_close {
    echo "%{$PR_RST%} "
}

PROMPT_SYMBOL="❯"

export VIRTUAL_ENV_DISABLE_PROMPT=1
PR_GIT_UPDATE=1

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

if [[ "${terminfo[colors]}" -ge 256 ]]; then
    red="%F{160}"
    orange="%F{208}"
    yellow="%F{10}"
    green="%F{64}"
    blue="%F{26}"
    turquoise="%F{80}"
    purple="%F{140}"
else
    red="%F{hotpink}"
    orange="%F{yellow}"
    yellow="%F{red}"
    green="%F{green}"
    blue="%F{blue}"
    turquoise="%F{cyan}"
    purple="%F{magenta}"
fi

PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c%{$PR_RST%})"
FMT_ACTION="(%{$green%}%a%{$PR_RST%})"
FMT_UNSTAGED="%{$orange%} ●"
FMT_STAGED="%{$green%} ✚"

zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%F{yellow%}%B--- %d%b"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true # disable if working with large repositories
zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

add-zsh-hook chpwd burgers_chpwd
add-zsh-hook precmd burgers_precmd
add-zsh-hook preexec burgers_preexec

function burgers_prompt() {
  local _brompt

  _brompt="$(burgers_prompt_path)"
  _brompt+="$(burgers_prompt_vcs)"
  _brompt+="$(burgers_prompt_pyenv)"
  _brompt+="$(burgers_prompt_aws)"
  _brompt+="$(burgers_prompt_exitcode)"
  _brompt+="\n"
  _brompt+="$(burgers_prompt_symbol)"
  _brompt+="$(burgers_prompt_close)"

  echo "${_brompt}"
}

PROMPT='$(burgers_prompt)'
