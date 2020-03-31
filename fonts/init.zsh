# Import Fonts

# Powerline Fonts
POWERLINE_FONTS_DIR="$ZSH_CACHE_DIR/PowerlineFonts"
POWERLINE_FONTS_REPO="git@github.com:powerline/fonts.git"

test -d ${POWERLINE_FONTS_DIR} || git clone "${POWERLINE_FONTS_REPO}" "${POWERLINE_FONTS_DIR}";
test -f ${FONTS_DIR}/Hack-Regular.ttf || sh "${POWERLINE_FONTS_DIR}/install.sh";

# Hasklig
hasklig_install "1.1" "${ZSH_CACHE_DIR}/Hasklig"
