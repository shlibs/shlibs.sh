#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Ref: https://github.com/termux/termux-packages/issues?q=BOOTCLASSPATH
# Ref2: https://github.com/termux/termux-app/issues?q=BOOTCLASSPATH
# Export to shell usage: ` . bootclasspath.sh `
#####################################################################
set -eu
BOOTCLASSPATH=""
[ -d /system ] && DIRLIST="$(find -L /system -type f -iname "*.jar")" || printf "%s" "Signal system DIRLIST ${0##*/} bootclasspath.sh generated.  "
# [ -d /vendor ] && DIRLIST="$DIRLIST $(find /vendor -type f -iname "*.jar")" || printf "%s" "Signal vendor DIRLIST ${0##*/} bootclasspath.sh generated.  "
for LIB in $DIRLIST
do
	BOOTCLASSPATH=${LIB}:${BOOTCLASSPATH};
done
BOOTCLASSPATH=${BOOTCLASSPATH%%:}
export BOOTCLASSPATH
# bootclasspath.sh EOF
