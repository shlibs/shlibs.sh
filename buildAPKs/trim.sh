#!/usr/bin/env sh
# Copyright 2021 (c) by S D Rausty all rights reserved;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Deletes '.git' directories and '*.log' files in ~/buildAPKs in order to save space in the $HOME/buildAPKs directory.
#####################################################################
set -eu
# RDR="$HOME/buildAPKs"		# define project root directory
_DLGDIRS_ () {	# delete '.git' directories
	find "$RDR"/sources/ -type d -name \.git > "$RDR"/tmp/del.dirs.file
	grep -v '^ *#' < "$RDR"/tmp/del.dirs.file | while IFS= read -r DELDIR
	do
	rm -rf "$DELDIR" && printf '%s\n' "Deleted directory '$DELDIR '."
	done
	rm  -f "$RDR"/tmp/del.dirs.file
}
_DLFILES_ () { # delete '*.log' files
	 printf '%s\n' "Deleting '*.log' files in directory '$RDR/var/log/'." && find "$RDR"/var/log/ -type f -name "*.log" -delete
}
_DOTRIMN_ () {	# delete '.git' directories
DFEM="$(df | grep emulated)"
printf '%s\n' "$DFEM"
_DELDIRS_ ; _DLFILES_
printf '%s\n' "Before:	$DFEM"
DFEM="$(df | grep emulated)"
printf '%s\n' "After:	$DFEM"
}
# trim.sh EOF
