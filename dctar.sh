#!/usr/bin/env sh
# Copyright 2019-2021 (c) all rights reserved by S D Rausty, see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# File ` dctar.sh ` deletes corrupt *.tar.gz files.
################################################################################
set -eu

_MAINDCTAR_ () {
	_PRINTPTF_
	if [ "$1" = 0 ] # the first agrurment equals 0
	then	# process
		if [ "${PWD##*/}" = tarballs ]
		then
			LTYPE="$(ls)" || _PRINTCPF_
			_PTGS_
		else
			_PRINTCPF_
		fi
	elif [ "$1" = ls ] # finds and removes corrupt tarballs with ls; depth 1
	then
		LTYPE="$(ls *.tar.gz)" || _PRINTCPF_
		_PTGS_
	elif [ "$1" = lsf ] # finds and removes corrupt tarballs with ls; depth 2
	then
		LTYPE="$(ls -d -1 ./**/*.tar.gz)" || _PRINTCPF_
		_PTGS_
	elif [ "$1" = find ] # finds and removes corrupt tarballs with find; depth unlimited
	then
		LTYPE="$(find . -type f -name "*.tar.gz")" || _PRINTCPF_
		_PTGS_
	elif [ "$1" = find2 ] # finds and removes corrupt tarballs with find; depth 2
	then
		LTYPE="$(find . -maxdepth 2 -type f -name "*.tar.gz")" || _PRINTCPF_
		_PTGS_
	elif [ "$1" = find3 ] # finds and removes corrupt tarballs with find; depth 3
	then
		LTYPE="$(find . -maxdepth 3 -type f -name "*.tar.gz")" || _PRINTCPF_
		_PTGS_
	else
		_PTG_ "$1"
	fi
	_PRINTMDONE_
}

_PRINTCPF_ () {
	printf "%s\\n" "Cannot process *.tar.gz files!"
}

_PRINTDONE_ () {
	printf "DONE\\n"
}

_PRINTMDONE_ () {
	printf "%s\\n" "Processing *.tar.gz files: DONE"
	printf "\033]2;%sDONE\007" "Processing *.tar.gz files: "
}

_PRINTHDCT_ () {
	printf "%s\\n%s\\n" "Options for \` ${0##*/} \` are:" "0	see \` cat ${0##*/} \` for more information"
	grep -w "elif \[" "$0" | awk '{print $5" "$8" "$9" "$10" "$11" "$12" "$13" "$14" "$15" "$16}'
	printf "%s\\n" "The script \` ${0##*/} \` should be run with an option as \` ${0##*/} \` removes *.tar.gz files as requested through options."
}

_PRINTPTF_ () {
	printf "%s\\n" "Processing *.tar.gz files: "
	printf "\033]2;%sOK\007" "Processing *.tar.gz files: "
}

_PTGS_ () { # process and remove *.tar.gz files with errors
	for FNAME in $LTYPE
	do
		printf "%s" "Processing file $FNAME: "
		if ! tar tf "$FNAME" 1>/dev/null
		then
			rm -f "$FNAME"
		fi
		printf "%s\\n" "DONE"
	done
}

_PTG_ () { # process and remove a *.tar.gz file with errors
	if ! tar tf "$1" 1>/dev/null
	then
		rm -f "$1"
	fi
}

[ -z "${1:-}" ] && _PRINTHDCT_ || _MAINDCTAR_ "$@"
# dctar.sh EOF
