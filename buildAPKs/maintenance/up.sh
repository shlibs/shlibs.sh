#!/usr/bin/env sh
# Copyright 2019-2021 (c) all rights reserved by BuildAPKs, see LICENSE
# https://shlibs.github.io/shlibs.sh published courtesy https://pages.github.com
# Updates the BuildAPKs git repository and git submodules to the newest version.
################################################################################
set -eu

_CSLIST_ () {	# create checksum file RDR/.conf/sha512.sum and compare with RDR/sha512.sum
	FAUTH="DOSO DOSON DRLIM EXTSTDO GAUTH LIBAUTH QUIET RDR" # exemption file list
	CSLICK=1	# false: files have not changed
	GEFAUTH="-e .gitmodules"
	cd "$RDR"/.conf/
	sha512sum $FAUTH > sha512.sum	# create checksum file RDR/.conf/sha512.sum
	for QAUTH in $FAUTH	# each element in FAUTH
	do	# find and compare hashes
		CAUTH=$("$COMDGREP" "$QAUTH" "$RDR/.conf/sha512.sum" | awk '{print $1}')
		RAUTH=$("$COMDGREP" "$QAUTH" "$RDR/sha512.sum" | awk '{print $1}')
		if [ "$RAUTH" != "$CAUTH" ]	# hashes differ
		then	# reassign these variables
			GEFAUTH="$GEFAUTH -e $QAUTH"	# build GEFAUTH string
			CSLICK=0	# true: files have changed
		fi
	done
	cd "$RDR"
		"$COMDGREP" -v -e ./setup.buildAPKs.bash $GEFAUTH "$RDR/sha512.sum" > "$RDR/var/tmp/${0##*/}.$$.tmp"
	if [ "$CSLICK" = 0 ]
	then
		"$COMDGREP" -v -e ./setup.buildAPKs.bash "$GEFAUTH" "$RDR/sha512.sum" > "$RDR/var/tmp/${0##*/}.$$.tmp"
	else
		"$COMDGREP" -v ./setup.buildAPKs.bash "$RDR/sha512.sum" > "$RDR/var/tmp/${0##*/}.$$.tmp"
	fi
	if sha512sum -c --quiet "$RDR/var/tmp/${0##*/}.$$.tmp" 2>/dev/null
	then
		printf "%s\\n"  "Checking checksums in directory ~/${RDR##*/} with sha512sum: DONE"
	else
		sha512sum -c "$RDR/var/tmp/${0##*/}.$$.tmp"
		printf "%s\\n"  "Checking checksums in directory ~/${RDR##*/} with sha512sum: DONE"
	fi
	rm -f "$RDR/var/tmp/${0##*/}.$$.tmp" "$RDR/.conf/sha512.sum" # remove checksum file .conf/sha512.sum and temp file
}

_PESTRG_ () {	# print WSTRING warning message
	_PRNT_ "$WSTRING"
}

_PRCS_ () {	# print checksums message and run sha512sum
	_PRT_  "Checking checksums in directory ~/${RDR##*/}/$IMFSTRG with sha512sum: "
	if "$COMDGREP" "\.\/\.scripts\/maintenance\/" sha512.sum 1>/dev/null
	then
		sed -i '/\.\/\.scripts\/maintenance\//d' sha512.sum
	fi
	sha512sum -c --quiet sha512.sum 2>/dev/null || sha512sum -c sha512.sum
	_PRNT_ "DONE"
}

_PRNT_ () {	# print message with one trialing newline
	printf "%s\\n" "$1"
}

_PRT_ () {	# print message with no trialing newline
	printf "%s" "$1"
}

_UP_ () {	# add or update git submodule repository
	( ( git submodule update --depth 1 --recursive --remote "$IMFSTRG" || git submodule add --depth 1 "$MRASTRG" "$IMFSTRG" ) && cd "$RDR/$IMFSTRG" && _PRCS_ && cd "$RDR" ) || _PESTRG_	# the command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information about git submodules.
	sleep 0.$(shuf -i 24-72 -n 1)	# enhance device and network latency support on fast networks;  See ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` for complementary latency applications of ` sleep ` when BuildAPKs is installed.  You can use https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/setup.buildAPKs.bash to set ~/buildAPKs up on device with ` curl -OL https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/setup.buildAPKs.bash ; bash setup.buildAPKs.bash `.  It appears that a little sleep can go a long way in reducing network collisions on fast networks.
}

_PRNT_ "Script ${0##*/}: STARTED..."
WSTRING="WARNING: Could not determine grep command ${0##*/}; Continuing...  "	# define WSTRING warning message
if command -v /system/bin/grep 1>/dev/null
then
COMDGREP="/system/bin/grep"	# define COMDGREP
elif command -v grep 1>/dev/null
then
COMDGREP="grep"	# define COMDGREP
else
_PESTRG_
COMDGREP="grep"	# define COMDGREP
fi
WSTRING="WARNING ${0##*/}; Continuing...  "	# define WSTRING warning message
RDR="$HOME/buildAPKs"		# define root directory
SIAD="https://github.com"	# define site address
SIADS="$SIAD/BuildAPKs"	# define remote login
cd "$RDR"	# change directory to root directory
git pull || ( git add && git commit && git pull ) || ( printf "%s\\n"  "Please study the output.  Directory '~/${RDR##*/}/stash' can be used to store files if 'error: Your local changes to the following files would be overwritten by merge:' is found. Then please use this script again to update ~/${RDR##*/} to the most recent version published." && exit 204 )	# update local git repository to the newest version
_CSLIST_ || _PESTRG_	# run function _PESTRG_ if function _CSLIST_ errs
sleep 0.$(shuf -i 24-72 -n 1)	# add device and network latency support;  Commands like this script can request many read write operations.  The sleep plus shuf commands cause this script to wait for a short pseudo random period of time.  This can ease excessive device latency when running these build scripts.
if "$COMDGREP" gitmodules sha512.sum 1>/dev/null
then
sed -i '/gitmodules/d' sha512.sum && git add sha512.sum && git commit -m "commit $(date)"
fi
rm -f opt/api/github/.git opt/db/.git scripts/bash/shlibs/.git scripts/sh/shlibs/.git || _PESTRG_	# remove automatically generated submodule .git files which were created through the process of cloning and updating git repositories as submodules
IMFSTRG="opt/api/github"	# define install module folder
MRASTRG="$SIADS/buildAPKs.github"	 # define module repository site
_UP_	# add or update git submodule repository
IMFSTRG="opt/db" # redefine install module folder
MRASTRG="$SIADS/db.BUildAPKs"	# redefine module repository site address
_UP_
SIADS="$SIAD/shlibs"	# redefine login
IMFSTRG="scripts/bash/shlibs"
MRASTRG="$SIADS/shlibs.bash"
_UP_
IMFSTRG="scripts/sh/shlibs"
MRASTRG="$SIADS/shlibs.sh"
_UP_
( _PRT_ "Removing '.git' files: " && find "$RDR/sources/" -maxdepth 2 -type f -name .git -delete && _PRNT_ "DONE" ) || _PESTRG_
_PRNT_ "Script ${0##*/}: DONE"
# up.sh EOF
