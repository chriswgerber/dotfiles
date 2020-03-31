# ZSH
# -dot-add-symlink-to-home iterm/profiles/zsh.json Library/Application\ Support/iTerm2/DynamicProfiles/zsh.json
# -dot-add-symlink-to-home iterm/profiles/zsh_bright.json Library/Application\ Support/iTerm2/DynamicProfiles/zsh_bright.json
# -dot-add-symlink-to-home iterm/profiles/zsh_muted.json Library/Application\ Support/iTerm2/DynamicProfiles/zsh_muted.json

# Bash
# -dot-add-symlink-to-home iterm/profiles/bash.json Library/Application\ Support/iTerm2/DynamicProfiles/bash.json

test -d $ITERM_THEMES_DIR ||
  git clone git@github.com:rainglow/iterm.git $ITERM_THEMES_DIR;
