#!/usr/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds directories in ~/$RDR/var/ from arguements
#####################################################################
set -eu

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
			mkdir -p "$RDR/var/$DIR" 
		fi
	done
}
# mkdirs.sh EOF
