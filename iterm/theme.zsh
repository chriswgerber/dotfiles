# Terminal Theme / Layout
#!/bin/zsh

# Pick from `curl -s https://gist.githubusercontent.com/justinabrahms/1047767/raw/a79218b6ca8c1c04856968d2d202510a4f7ec215/colortest.py | python2`

function prompt_get_fg() {
  local fg=$1 color
  local -A themecolors=(
    [red]=196
    [orange]=208
    [yellow]=220
    [green]=70
    [blue]=32
    [turquoise]=67
    [purple]=141
    [white]=255
    [reset]=255
  )

  if [[ "${fg}" = "-" ]]; then
    color="%f"
  else
    if [ ${themecolors[${1}]+abc} ]; then
      color="%F{$themecolors[${1}]}"
    else
      color="%F{255}"
    fi
  fi
  echo -n "$color"
}

function prompt_segment() {
  local fg=$1 content=$2

  echo -n "%{$(prompt_get_fg ${fg})%}"
  echo -n $content
  echo -n "$(prompt_get_fg -)"
}

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

function dotfiles_prompt_path() {
  prompt_segment green "%~ "
}

function dotfiles_prompt_vcs() {
  prompt_segment reset "$vcs_info_msg_0_ "
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

function dotfiles_prompt_date() {
  prompt_segment purple "$(date +'%r %F')"
  echo -n " "
}

function dotfiles_prompt_symbol() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && prompt_segment green "⚙ "
  echo -n "%(?.%F{white}.%F{red})${PROMPT_SYMBOL} "
}

function dotfiles_set_zstyle() {
  zstyle ':vcs_info:*' enable git

  zstyle ':completion:*' verbose yes
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*:descriptions' format "$(prompt_get_fg blue)%B--- %d%b"

  FMT_BRANCH="($(prompt_segment yellow '%b%u%c'))"
  FMT_ACTION="($(prompt_segment green '%a'))"
  FMT_UNSTAGED=$(prompt_segment orange " ●")
  FMT_STAGED=$(prompt_segment green " ✚")

  zstyle ':vcs_info:*:prompt:*' check-for-changes true # disable if working with large repositories
  zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
  zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
  zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  add-zsh-hook preexec dotfiles_preexec
  add-zsh-hook chpwd dotfiles_chpwd
  add-zsh-hook precmd dotfiles_precmd
}

function dotfiles_prompt() {
  dotfiles_set_zstyle

  dotfiles_prompt_date
  dotfiles_prompt_path
  dotfiles_prompt_vcs
  dotfiles_prompt_pyenv
  dotfiles_prompt_aws
  dotfiles_prompt_gcp
  dotfiles_prompt_exitcode
  echo -n "\n"
  dotfiles_prompt_symbol
}

PS1='$(dotfiles_prompt)'
