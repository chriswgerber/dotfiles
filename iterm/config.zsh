# Iterm

autoload -Uz promptinit
autoload -U add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

-dot-fpath-add "${DOTFILES_DIR}/iterm/functions"
-dot-fpath-add "${DOTFILES_DIR}/iterm/completions" "skip"
-dot-fpath-add "${DOTFILES_DIR}/iterm/prompts" "skip"

export ITERM_THEMES_DIR="${DOT_CACHE_DIR}/iterm-themes"

export PROJECT
export WORKSPACE

export PROMPT_SYMBOL="\u27e9"
export PROMPT_VCS_SYMBOL="\ue0a0"

export PR_GIT_UPDATE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
