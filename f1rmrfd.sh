#!/bin/env sh
# Copyright 2019 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# This file:  ` f1rmrfd.sh `  deletes directories at find -maxdepth 1 
#####################################################################
set -eu
_F1RMRFMAIN_ () {
	FDIRL=$(ls --color=never)
	for RMRFDIR1 in $FDIRL
	do
		find "$RMRFDIR1" -maxdepth 1 -type d -exec rm -rf {} \; ||:
	done
}

_PRINTHDCT_ () {
	printf "%s\\n" "See \` cat $0 \` for more information as \` ${0##*/} \` removes directories as requested!  "
	printf "%s\\n" "\` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes directories.  The \` ${0##*/} \` command can be useful in ~/buildAPKs/sources/github/{users,orgs}/\$JDR when resetting the ~/buildAPKs/sources/github/{users,orgs}/\$JDR directories."
}

[ -z "${1:-}" ] && _PRINTHDCT_ || _F1RMRFMAIN_ "$@" 
# f1rmrfd.sh EOF
