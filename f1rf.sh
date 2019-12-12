#!/bin/env sh
set -eu
_MAINDCTAR_ () {
	O1DIR=$PWD
	FDIRL=$(ls)
	for RMRFDIR1 in $FDIRL
	do
		find $RMRFDIR1 -maxdepth 1 -type d -exec rm -rf {} \;
		printf "%s\\n" "${PWD##*/}"
		cd $O1DIR
	done
}

_PRINTHDCT_ () {
	printf "%s\\n" "See \` cat $0 \` for more information as \` ${0##*/} \` removes directories as requested with the following command:"
	grep -w find "$0" | head -1 
	grep -w "elif \[" "$0" | awk '{print $5"	"$8" "$9" "$10" "$11" "$12" "$13}'
	printf "%s\\n" "\` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes directories."
}

[ -z "${1:-}" ] && _PRINTHDCT_ || _MAINDCTAR_ "$@" 
# f1rf.sh EOF
