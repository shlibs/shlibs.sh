#!/bin/env sh
set -eu
_MAINDCTAR_ () {
	g=$PWD
	h=$(ls)
	for i in $h
	do
		cd $i && find . -maxdepth 1 -type d -exec rm -rf {} \;
		printf "%s\\n" "${PWD##*/}"
		cd $g
	done
}

_PRINTHDCT_ () {
	printf "%s\\n%s\\n" "Options for \` ${0##*/} \` are:" "See \` cat $0 \` for more information."
	grep -w "cd\ " "$0" | head -1 
	grep -w "elif \[" "$0" | awk '{print $5"	"$8" "$9" "$10" "$11" "$12" "$13}'
	printf "%s\\n" "\` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes directories as requested."
}

[ -z "${1:-}" ] && _PRINTHDCT_ || _MAINDCTAR_ "$@" 
# f1rf.sh EOF
