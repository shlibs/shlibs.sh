#!/bin/env sh
# Copyright 2019 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# This file:  ` f1rmrfd.sh `  deletes directories at find -maxdepth 1 
#####################################################################
set -eu
_F1RMRFMAIN_ () {
	O1DIR=$PWD
	FDIRL=$(ls --color=never)
	for RMRFDIR1 in $FDIRL
	do
		find "$RMRFDIR1" -maxdepth 1 -type d -exec rm -rf {} \; ||:
		printf "%s\\n" "${PWD##*/}"
		cd "$O1DIR"
	done
}

_PRINTHDCT_ () {
	printf "%s\\n" "See \` cat $0 \` for more information as \` ${0##*/} \` removes directories as requested with the following command:"
	grep -w find "$0" | head -1 
	printf "%s\\n" "\` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes directories.  The \` ${0##*/} \` command can be useful in ~/buildAPKs/sources/github/{users,orgs}/\$JDR when resetting the ~/buildAPKs/sources/github/{users,orgs}/\$JDR directories."
}

[ -z "${1:-}" ] && _PRINTHDCT_ || _F1RMRFMAIN_ "$@" 
# f1rmrfd.sh EOF
