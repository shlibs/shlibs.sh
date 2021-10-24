#!/usr/bin/env sh
# Copyright 2021 (c) by S D Rausty all rights reserved;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Deletes '.git' directories and '*.log' files in ~/buildAPKs in order to save space in the $HOME/buildAPKs directory.
#####################################################################
set -eu
RDR="$HOME/buildAPKs"		# define project root directory
_DELDIRS_ () {	# delete '.git' directories
	find "$RDR"/sources/ -type d -name \.git > "$RDR"/tmp/del.dirs.file
	for DELDIR in $(cat "$RDR"/tmp/del.dirs.file) ; do rm -rf "$DELDIR" && printf '%s\n' "Deleted directory '$DELDIR '." && rm  -f "$RDR"/tmp/del.dirs.file ; done
}
_DELFILES_ () { # delete '*.log' files
	 printf '%s\n' "Deleting '*.log' files in directory '$RDR/var/log/'." && find "$RDR"/var/log/ -type f -name "*.log" -delete
}
DFEM="$(df | grep emulated)"
printf '%s\n' "$DFEM"
_DELDIRS_ ; _DELFILES_
printf '%s\n' "Before:	$DFEM"
DFEM="$(df | grep emulated)"
printf '%s\n' "After:	$DFEM"
# trim.sh EOF
