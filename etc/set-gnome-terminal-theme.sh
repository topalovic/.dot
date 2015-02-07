#!/usr/bin/env bash
#
# A simple script to set GNOME Terminal style. It creates
# a new default profile via dconf, named after user.

set -eu

declare -A deps=(
  ["dconf"]="dconf-cli"
  ["uuidgen"]="uuid-runtime"
)

for dep in "${!deps[@]}"
do
  dep_missing="$dep not found.\n"
  dep_missing+="$ sudo apt-get install ${deps["$dep"]}?"
  type -P $dep &>/dev/null || { echo -e $dep_missing; exit 1; }
done

# Slight variation of Zenburn

bold_color="'#E3E3CECEABAB'"
fg_color="'#DCDCDCDCCCCC'"
bg_color="'#2E2E34343636'"
palette="['#2E2E34343636', '#CCCC93939393', '#7F7F9F9F7F7F', '#E3E3CECEABAB', '#DFDFAFAF8F8F', '#CCCC93939393', '#8C8CD0D0D3D3', '#DCDCDCDCCCCC',
          '#3F3F3F3F3F3F', '#CCCC93939393', '#7F7F9F9F7F7F', '#E3E3CECEABAB', '#DFDFAFAF8F8F', '#CCCC93939393', '#8C8CD0D0D3D3', '#DCDCDCDCCCCC']"

dset () {
  dconf write "$@"
}

profile_name=$USER
profile_id="$(uuidgen)"
profiles=/org/gnome/terminal/legacy/profiles:
profile="$profiles/:$profile_id"

echo "Creating default profile '$profile_name'... "

dset $profiles/list "['$profile_id']"
dset $profiles/default "'$profile_id'"
dset $profile/visible-name "'$profile_name'"
dset $profile/bold-color $bold_color
dset $profile/foreground-color $fg_color
dset $profile/background-color $bg_color
dset $profile/palette "$palette"
dset $profile/use-theme-colors "false"
dset $profile/bold-color-same-as-fg "false"
dset $profile/scrollback-unlimited "true"
dset $profile/scrollbar-policy "'never'"

echo "Done."
echo
echo "Your new profile can be found at:"
echo "$profile"
echo
echo "To nuke the profile setup:"
echo "$ dconf reset -f \"$profiles/\""

exit 0
