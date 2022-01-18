#!/usr/bin/env sh
# Copyright 2021-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# strip leading whitespaces, then trim slashes with newlines
################################################################################
set -eu
_SLWTTSWN_() {
awk '{ sub(/^[ \t]+/, ""); print }' "$1" | awk '{if (sub(/\\$/,"")) printf "%s", $0; else print $0}'
}
# _SLWTTSWN_ "$@"
# trim.newline.slash.sh EOF
