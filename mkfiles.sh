#!/usr/bin/env sh
# Copyright 2019-2021 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds files to $RDR/var/ from arguments
#####################################################################
set -eu

_MKVFILES_ () { # create list from arguments
	ARGS="$@"
	NAMESFL=""
	for ARG in $ARGS
	do
		NAMESFL="$NAMESFL $ARG"
	done
	for AFILE in $NAMESFL
	do
		if [ ! -e  "$RDR/var/$AFILE" ] # AFILE does not exist in RDR/var
		then # create AFILE in RDR/var
			touch "$RDR/var/$AFILE" 
		fi
	done
}
# mkfiles.sh EOF
