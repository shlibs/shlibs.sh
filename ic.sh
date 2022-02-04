#!/usr/bin/env sh
# Copyright 2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://shlibs.github.io/shlibs.sh published courtesy https://pages.github.com
# Checks device wireless connection.
################################################################################
set -eu
_RUNCHECK_() {
if [ -e /system/bin/ping ]
then
set +e
PNGVAR="$(/system/bin/ping -n 1 1.1.1.1 2>&1)"
else
set +e
PNGVAR="$(ping -n 1 1.1.1.1 2>&1)"
fi
set -e
if [ -n "${PNGVAR##*unreachable*}" ]
then
	printf 'Connected;  Exiting... \n'
else
	printf 'Not connected;  Exiting... \n'
fi
}
_RUNCHECK_
# shlibs/shlibs.sh/ic.sh EF
