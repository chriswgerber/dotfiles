## Ruby
export RBENV_ROOT="$HOME/.rbenv"

# Chef
-dot-path-add "/opt/chefdk/bin"
-dot-path-add "/opt/chefdk/embedded/bin"
-dot-path-add "$HOME/.chefdk/gem/ruby/2.3.0/bin"

# Aliases
alias rake="noglob rake"
alias be="bundle exec"
alias ce="chef exec"
