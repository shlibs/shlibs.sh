#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty;  see  LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# R1 https://github.com/termux/termux-packages/issues?q=BOOTCLASSPATH
# Refer2: https://github.com/termux/termux-app/issues?q=BOOTCLASSPATH
# Export to shell usage: ` . bootclasspath.sh ` # the dot is required
#####################################################################
set -eu
BOOTCLASSPATH=""
[ -d /system ] && DIRLIST="$(find -L /system -type f -iname "*.jar" -or -iname "*.apk" 2>/dev/null)" || printf "%s" "Signal system DIRLIST ${0##*/} bootclasspath.sh generated.  "
for LIB in $DIRLIST
do
	BOOTCLASSPATH=${LIB}:${BOOTCLASSPATH};
done
BOOTCLASSPATH=${BOOTCLASSPATH%%:}
export BOOTCLASSPATH
# bootclasspath.sh EOF
