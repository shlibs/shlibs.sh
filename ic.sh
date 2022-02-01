#!/usr/bin/env sh
# Copyright 2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://shlibs.github.io/shlibs.sh published courtesy https://pages.github.com
# Checks device wireless connection.
################################################################################
set -eu
_RUNCHECK_() {
set +e
PNGVAR="$(/system/bin/ping -n 1 1.1.1.1 2>&1)"
set -e
if [ -n "${PNGVAR##*No*}" ]
then
set +e
PNGVAR="$(ping -n 1 1.1.1.1 2>&1)"
set -e
fi
if [ -n "${PNGVAR##*unreachable*}" ]
then
	CHKVAR=0 && printf 'Connected;  Exiting... \n'
else
	CHKVAR=1 && printf 'Not connected;  Exiting... \n'
fi
} && _RUNCHECK_
# ic.sh EF
