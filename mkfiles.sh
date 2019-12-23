#!/usr/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds files to ~/$RDR/var/ from arguements
#####################################################################
set -eu

_MKFILES_ () { # create list from arguements
	ARGS="$@"
	NAMESFL=""
	for ARG in $ARGS
	do
		NAMESFL="$NAMESFL $ARG"
	done
	for AFILE in $NAMESFL
	do
		if [ ! -f  "$RDR/var/$AFILE" ] # AFILE does not exist in ~/RDR/var/
		then # create AFILE in ~/RDR/var
			touch "$RDR/var/$AFILE" 
		fi
	done
}
# mkfiles.sh EOF
