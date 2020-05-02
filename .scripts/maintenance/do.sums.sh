#!/bin/env bash
# Copyright 2019-2020 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# To create checksum files and commit use; do.sums.bash
# To see file tree use; awk '{print $2}' sha512.sum
# To check the files use; sha512sum -c sha512.sum
#####################################################################
set -eu
TIME="$(date +%s)"
[ ! -f .git/ORIG_HEAD ] && git pull && MTIME="$TIME" || MTIME="$(ls -l --time-style=+"%s" .git/ORIG_HEAD | awk '{print $6}')"
(if [[ $(($TIME - $MTIME)) -gt 43200 ]]; then git pull; fi) || git pull
.scripts/maintenance/vgen.sh
rm -f *.sum
FILELIST=( $(find . -type f | grep -v .git | sort) )
CHECKLIST=(sha512sum) # md5sum sha1sum sha224sum sha256sum sha384sum
for SCHECK in ${CHECKLIST[@]}
do
	printf "%s\\n" "Creating $SCHECK file..."
	for FILE in "${FILELIST[@]}"
	do
		$SCHECK "$FILE" >> ${SCHECK::-3}.sum
	done
done
chmod 400 ${SCHECK::-3}.sum 
for SCHECK in  ${CHECKLIST[@]}
do
	printf "%s\\n" "Checking $SCHECK..."
	$SCHECK -c ${SCHECK::-3}.sum
done
git add .
# sn.sh is located at https://github.com/BuildAPKs/maintenance.BuildAPKs
SN="$(sn.sh)"
git commit -m "$SN"
git push
ls --color=always
printf "%s\\n" "$PWD"
# do.sums.bash EOF
