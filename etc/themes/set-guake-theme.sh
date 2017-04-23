#!/usr/bin/env bash
#
# A simple script to set Guake style and a global keyboard
# shortcut. It overrides existing values via gconftool-2,
# so backup first if needed.

set -eu

declare -A deps=(
  ["guake"]="guake"
  ["gconftool-2"]="gconf2"
)

for dep in "${!deps[@]}"
do
  dep_missing="$dep not found.\n"
  dep_missing+="$ sudo apt-get install ${deps["$dep"]}?"
  type -P $dep &>/dev/null || { echo -e $dep_missing; exit 1; }
done

# Slight variation of Zenburn

fg_color="#DCDCDCDCCCCC"
bg_color="#2E2E2E2E2E2E"
palette="#2E2E30303636:#CCCC93939393:#7F7F9F9F7F7F:#E3E3CECEABAB:#DFDFAFAF8F8F:#CCCC93939393:#8C8CD0D0D3D3:#DCDCDCDCCCCC:#3F3F3F3F3F3F:#CCCC93939393:#7F7F9F9F7F7F:#E3E3CECEABAB:#DFDFAFAF8F8F:#CCCC93939393:#8C8CD0D0D3D3:#DCDCDCDCCCCC"

gset () {
  gconftool-2 -s -t "$@"
}

base_path=/apps/guake
style_path=$base_path/style

echo "Setting default style..."

gset string $style_path/font/palette $palette
gset string $style_path/font/color $fg_color
gset string $style_path/background/color $bg_color

gset int  $style_path/background/transparency 2 # %
gset int  $base_path/general/window_height 100 # %
gset bool $base_path/general/use_scrollbar false

echo "Setting global keyboard shortcut..."

gset string $base_path/keybindings/global/show_hide "<Ctrl>grave"

echo "Done."
echo
echo "To reset style:"
echo "$ gconftool-2 --recursive-unset $style_path"

exit 0
