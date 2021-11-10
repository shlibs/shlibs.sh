#!/usr/bin/env sh
# Use imagemagick to see whether an image has almost no content.
FJPG="$(find . -name "*jpg")"
for FMMX in $FJPG
do
printf '%s\n' "$FMMX"
printf '%s\n' "$(convert "$FMMX" -format '%[mean] %[max]' info:- | awk '{print $1/$2}')"
done
# emptyimage.sh EOF
