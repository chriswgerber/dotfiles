#!/bin/zsh
# Dotfiles theme for Oh My Zsh
# License: MIT

PROMPT_SYMBOL="❯"

export VIRTUAL_ENV_DISABLE_PROMPT=1

PR_GIT_UPDATE=1

autoload -U add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

function prompt_get_fg() {
  local fg=$1

  if [[ "${terminfo[colors]}" -ge 256 ]]; then
    case "$fg" in
      red) echo -n "%F{160}" ;;
      orange) echo -n "%F{208}" ;;
      yellow) echo -n "%F{10}" ;;
      green) echo -n "%F{64}" ;;
      blue) echo -n "%F{26}" ;;
      turquoise) echo -n "%F{80}" ;;
      purple) echo -n "%F{140}" ;;
      *) echo -n "%f" ;;
    esac
    return
  fi

  case "$fg" in
    red) echo -n "%F{hotpink}" ;;
    orange) echo -n "%F{yellow}" ;;
    yellow) echo -n "%F{red}" ;;
    green) echo -n "%F{green}" ;;
    blue) echo -n "%F{blue}" ;;
    turquoise) echo -n "%F{cyan}" ;;
    purple) echo -n "%F{magenta}" ;;
    *) echo -n "%f" ;;
  esac

  return
}

function prompt_segment() {
  local fg=$(prompt_get_fg $1) content=$2

  echo -n "%{$fg%}"
  echo -n $content
  echo -n "$(prompt_get_fg -)"
}

zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%F{yellow%}%B--- %d%b"

zstyle ':vcs_info:*' enable git

FMT_BRANCH="($(prompt_segment turquoise '%b%u%c'))"
FMT_ACTION="($(prompt_segment green '%a'))"
FMT_UNSTAGED=$(prompt_segment orange " ●")
FMT_STAGED=$(prompt_segment green " ✚")
zstyle ':vcs_info:*:prompt:*' check-for-changes true # disable if working with large repositories
zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function dotfiles_preexec() {
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

function dotfiles_chpwd() {
  PR_GIT_UPDATE=1
}

function dotfiles_precmd() {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't.
        FMT_BRANCH="on "
        FMT_BRANCH+=$(prompt_segment turquoise " %b%u%c% ")

        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH+=$(prompt_segment red " ● ")
        fi

        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}


add-zsh-hook preexec dotfiles_preexec
add-zsh-hook chpwd dotfiles_chpwd
add-zsh-hook precmd dotfiles_precmd


function dotfiles_prompt_path() {
  prompt_segment green "%~ "
}

function dotfiles_prompt_vcs() {
  prompt_segment - "$vcs_info_msg_0_ "
}

function dotfiles_prompt_pyenv() {
  [ "$(pyenv version-name)" != "system" ] &&
    prompt_segment blue "pyenv:$(pyenv version-name) "
}

function dotfiles_prompt_aws() {
  local _prompt_profile=$AWS_DEFAULT_PROFILE

  (test -n $AWS_PROFILE && _prompt_profile=$AWS_PROFILE) || true

  test -n "$_prompt_profile" &&
    prompt_segment orange "aws:%U$_prompt_profile%u "
}

function dotfiles_prompt_gcp() {
  local _prompt_profile=$(gcpgp)

  test -n "$_prompt_profile" &&
    prompt_segment yellow "gcp:%U$_prompt_profile%u "
}

function dotfiles_prompt_exitcode() {
  prompt_segment red "%(?..C:%?)"
}

function dotfiles_prompt_symbol() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && prompt_segment green "⚙ "
  echo -n "%(?.%F{white}.%F{red})${PROMPT_SYMBOL} "
}

function dotfiles_prompt() {
  dotfiles_prompt_path
  dotfiles_prompt_vcs
  dotfiles_prompt_pyenv
  dotfiles_prompt_aws
  dotfiles_prompt_gcp
  dotfiles_prompt_exitcode
  echo -n "\n"
  dotfiles_prompt_symbol
}

# Set
PROMPT='$(dotfiles_prompt)'
