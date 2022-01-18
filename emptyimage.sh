#!/usr/bin/env sh
# Copyright 2021-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# Use imagemagick to see whether an image has almost no content.
################################################################################
FJPG="$(find . -name "*jpg")"
for FMMX in $FJPG
do
printf 'File %s mean/max = %s\n' "${FMMX##*/}'s" "$(convert "$FMMX" -format '%[mean] %[max]' info:- | awk '{print $1/$2}')"
done
# emptyimage.sh EOF
