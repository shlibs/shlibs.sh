#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# deletes corrupt *.tar.gz files 
#####################################################################
set -eu

_MAINDCTAR_ () {
	_PRINTPTF_ 
	if [ $1 = 0 ] # the first agrurment equals 0
	then	# process
		if [ "${PWD##*/}" = tarballs ]
		then
			LTYPE="$(ls)" || _PRINTCPF_ 
			_PTGS_
		else
			_PRINTCPF_ 
		fi
	elif [ $1 = ls ] # finds tarballs with ls; depth 1
	then
		LTYPE="$(ls *.tar.gz)" || _PRINTCPF_ 
		_PTGS_
	elif [ $1 = lsf ] # finds tarballs with ls; depth 2
	then
		LTYPE="$(ls -d -1 ./**/*.tar.gz)" || _PRINTCPF_ 
		_PTGS_
	elif [ $1 = find ] # finds tarballs with find; depth unlimited
	then
		LTYPE="$(find . -type f -name "*.tar.gz")" || _PRINTCPF_ 
		_PTGS_
	elif [ $1 = find2 ] # finds tarballs with find; depth 2
	then
		LTYPE="$(find . -maxdepth 2 -type f -name "*.tar.gz")" || _PRINTCPF_ 
		_PTGS_
	else
		_PTG_ $1
	fi
	_PRINTDONE_ 
}

_PRINTCPF_ () {
	printf "%s\\n" "Cannot process *.tar.gz files!"  
}

_PRINTDONE_ () {
	printf "DONE\\n"
	printf "\033]2;%sDONE\007" "Processing *.tar.gz files: "
}

_PRINTHDCT_ () {
	printf "%s\\n%s\\n" "Options for ${0##*/} are:" "0	see \` cat $0 \` for more information"
	grep -w "elif \[" "$0" | awk '{print $5"	"$8" "$9" "$10" "$11" "$12" "$13}'
	printf "%s\\n" "${0##*/} must be run with an option!"
}

_PRINTPTF_ () {
	printf "%s" "Processing *.tar.gz files: "
	printf "\033]2;%sOK\007" "Processing *.tar.gz files: "
}

_PTGS_ () { # process *.tar.gz files for errors
	for FNAME in $LTYPE
	do 
		if ! tar tf "$FNAME" 1>/dev/null 
		then 
			rm -f "$FNAME" 
		fi
	done
}

_PTG_ () { # process a *.tar.gz file for errors
	if ! tar tf "$1" 1>/dev/null 
	then 
		rm -f "$1" 
	fi
}

if [ -z "${1:-}" ]
then
	_PRINTHDCT_ 
else
	_MAINDCTAR_ "$@" 
fi
# dctar.sh EOF
