#!/usr/bin/env sh
# Copyright 2019-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# File  ` f3rmrfd.sh `  deletes files and subdirectories with find to
# rerun ` build.github.bash login ` and also to save space on device.
################################################################################
set -eu
export RDR="$HOME/buildAPKs"
_F1RMRFMAIN_ () {
	[ "${PWD%/*}" = "$RDR/sources/github/orgs" ] || [ "${PWD%/*}" = "$RDR/sources/github/users" ] && _F13R_ || printf "%s\\n\\n" "Run ${0##*/} in directory $RDR/sources/github/{orgs,users}/login to delete files and subdirectories;  Exiting...  " && exit
}

_F3RMRFMAIN_ () {
	[ "$PWD" = "$RDR/sources/github" ] && _F35R_ || printf "%s\\n\\n" "Run ${0##*/} in directory $RDR/sources/github to delete files and subdirectories;  Exiting...  " && exit
}

_F13R_ () {
	find . -mindepth 1 -maxdepth 1 -type d ! -name var -exec rm -rf {} \; || _PRINTSIG_ 62
	find . -mindepth 3 -maxdepth 3 -type f -name NAMES.db -delete || _PRINTSIG_ 64
	_DCTLS_
}

_F35R_ () {
	find "$RDR/sources/github" -mindepth 3 -maxdepth 3 -type d ! -name var -exec rm -rf {} \; || _PRINTSIG_ 66
	find "$RDR/sources/github" -mindepth 5 -maxdepth 5 -type f -name NAMES.db -delete || _PRINTSIG_ 68
	_DCTF3_
}

_DCTLS_ () {
	"$RDR/scripts/maintenance/delete.corrupt.tars.sh" ls
}

_DCTF3_ () {
	"$RDR/scripts/maintenance/delete.corrupt.tars.sh" find3
}

_PRINTSIG_ () {
	printf "%s\\n" "SIGNAL $1 GENERATED:  Continuing...  "
}

_PRINTHELP_ () {
	printf "%s\\n\\n" "See \` cat $0 \` for more information as \` ${0##*/} \` removes files and subdirectories as requested!  "
	cat $0
	printf "\\n%s\\n" "Script \` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes files and subdirectories as requested.  The \` ${0##*/} \` command can be useful in ~/buildAPKs/sources/github/ when resetting the ~/buildAPKs/sources/github/ subdirectories."
}
# Print help if no arguements are given, else do option 1 or 3.
( [ -z "${1:-}" ] && _PRINTHELP_ ) || ( [ "$1" = 1 ] && _F1RMRFMAIN_ ) || ( [ "$1" = 3 ] && _F3RMRFMAIN_ ) || _PRINTHELP_
# f3rmrfd.sh EOF
