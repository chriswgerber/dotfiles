## Ruby
export RBENV_ROOT="$HOME/.rbenv"

fpath=("${RBENV_ROOT}/completions" $fpath)

# Chef
-dot-add-path "/opt/chefdk/bin"
-dot-add-path "/opt/chefdk/embedded/bin"
-dot-add-path "$HOME/.chefdk/gem/ruby/2.3.0/bin"

# Aliases
alias rake="noglob rake"
alias be="bundle exec"
alias ce="chef exec"
