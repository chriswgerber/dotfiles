# Import Fonts

# Powerline Fonts
POWERLINE_FONTS_DIR="$ZSH_CACHE_DIR/PowerlineFonts"
-dot-install-github-repo "powerline/fonts" "${POWERLINE_FONTS_DIR}"
test -f ${FONTS_DIR}/Hack-Regular.ttf ||
  sh "${POWERLINE_FONTS_DIR}/install.sh";

# Hasklig
hasklig_install "1.1" "${ZSH_CACHE_DIR}/Hasklig"
