#!/usr/bin/env sh
# Copyright 2019-2020 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds directories in $RDR/var/ from arguements
#####################################################################
set -eu

_MKRDIRS_ () { # create list from arguements
	ARGS="$@"
	NAMESFL=""
	for ARG in $ARGS
	do
		NAMESFL="$NAMESFL $ARG"
	done
	for DIR in $NAMESFL
	do
		if [ ! -d  "$RDR/$DIR" ] # DIR does not exist in ~/RDR/var/
		then # create directory DIR in ~/RDR/var/
			mkdir -p "$RDR/$DIR" || printf "%s\\n" "Signal generated at mkdir -p "$RDR/$DIR" ${0##*/} mkdirs.sh : Continuing : " 
		fi
	done
}

_MKDIRS_ () { # create list from arguements
	ARGS="$@"
	NAMESFL=""
	for ARG in $ARGS
	do
		NAMESFL="$NAMESFL $ARG"
	done
	for DIR in $NAMESFL
	do
		if [ ! -d  "$RDR/var/$DIR" ] # DIR does not exist in ~/RDR/var/
		then # create directory DIR in ~/RDR/var/
			mkdir -p "$RDR/var/$DIR" || printf "%s\\n" "Signal generated at mkdir -p "$RDR/var/$DIR" ${0##*/} mkdirs.sh : Continuing : " 
		fi
	done
}
# mkdirs.sh EOF
