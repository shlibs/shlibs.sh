#!/usr/bin/env sh
# Copyright 2019-2021 (c)  all rights reserved by S D Rausty;  see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds user names to *NAMES* file(s) if not found
#####################################################################
set -eu

_ANAMESDB_ () { # add NAMES if NAMES is not found in NAMES.db
	if ! grep -iw "$NAMES" "$JDR/var/conf/NAMES.db" 1>/dev/null
	then
		printf "%s" "Adding $NAMES to $JDR/var/conf/NAMES.db  "
		printf "%s\\n" "$NAMES" >> "$JDR/var/conf/NAMES.db"
	fi
}

_NAMESMAINBLOCK_ () { # create *NAMES* file list and process $USENAME
	if [[ ! -f "$JDR/var/conf/NAMES.db" ]]
	then
		touch "$JDR/var/conf/NAMES.db"
	fi
	ARGS="$@"
	NAMESFL=""
	for ARG in $ARGS
	do
		NAMESFL="$NAMESFL $ARG"
	done
	if [ -z "${NAMESFL##*log*}" ] # https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
	then
		for OPT in $NAMESFL
		do
			NAMES="$OPT"
		  	_NAMESLOG_
		done
	else
		for OPT in $NAMESFL
		do
			NAMES="$OPT"
		  	_NAMES_
		done
	fi
}

_NAMES_ () { # check if USENAME is found in NAMES file, and add USENAME to file if not found
	if ! grep -iw "$NAMES" "$JDR/var/conf/NAMES.db" 1>/dev/null # USENAME is not found in NAMES.db file
	then # add USENAME to NAMES if not already added
		_PRINTPRN_
		if ! grep -iE "(^|[^-])\b^$USENAME\b($|[^-])" "$RDR/var/db/$NAMES" 1>/dev/null # USENAME is not found in NAMES file
		then # add USENAME to NAMES file
			printf "%s" "Adding $USENAME to ~/${RDR##*/}/var/db/$NAMES: "
			printf "%s\\n" "$USENAME" >> "$RDR/var/db/$NAMES"
		else # print message if USENAME is found in NAMES file
			printf "%s" "NOT adding $USENAME to ~/${RDR##*/}/var/db/$NAMES: $USENAME is already in file $NAMES: "
		fi
		_ANAMESDB_
		_PRINTDONEN_
	fi
}

_NAMESLOG_ () { # check if USENAME is found in NAMES file, and adds USENAME, DS (download size), BT (build time), NAMFS (number of AndroidManifest.xml files) and NAPKS (number of APK files) to NAMES file if not found
	TDATE="$(date +%Y%m%d)"
	if ! grep -iw "$NAMES" "$JDR/var/conf/NAMES.db" 1>/dev/null # NAMES is not found in NAMES.db
	then # add USENAME, DS, BT, NAMFS and NAPKS to NAMES file
		_PRINTPRN_
		BT="$(( $(date +%s)-$ST ))" # calculate build time
		if [ ! -f "$JDR/var/conf/DS.db" ] # DS.db does not exist in JDR/var/ conf
		then	# assign DS as 1
			DS="1"
		else	# assign DS as download size
			DS="$(cat "$JDR/var/conf/DS.db")" || printf "%s\\n" "WARNING: ${0##*/} names.sh _NAMESLOG_ DS"
		fi
		: ${DS:=1}	# assign DS as 1 if DS is undefined
		# if file exists, get number of AndroidManifest.xml files found or set NAMFS to zero
		[[ -f "$JDR/var/conf/NAMFS.db" ]] && NAMFS="$(cat $JDR/var/conf/NAMFS.db)" || NAMFS=0
		# if file exists, get names of AndroidManifest.xml files found or set NAMKS to nothing
		[[ -f "$JDR/var/conf/NAMKS.db" ]] && NAMKS="$(awk 1 ORS=' ' $JDR/var/conf/NAMKS.db)" || NAMKS=""
		# if file exists, get number of APKs built or set NAPKS to zero
		[[ -f "$JDR/var/conf/NAPKS.db" ]] && NAPKS="$(cat $JDR/var/conf/NAPKS.db)"
		if ! grep -iE "(^|[^-])\b^$USENAME\b($|[^-])" "$RDR/var/db/$NAMES" 1>/dev/null # USENAME is not found in NAMES file
		then # add USENAME, DS, BT, NAMFS and NAPKS to NAMES file
			if [ -z "${NAMESFL##*GNAMES*}" ]
			then
				printf "%s" "Adding $USENAME $NAPKS to ~/${RDR##*/}/var/db/$NAMES: "
				printf "%s %s\\n" "$USENAME $NAPKS" >> "$RDR/var/db/$NAMES"
			else
				printf "%s" "Adding $USENAME $TDATE $DS $BT $NAMFS $NAPKS $NAMKS to ~/${RDR##*/}/var/db/$NAMES: "
				printf "%s %s\\n" "$USENAME $TDATE $DS $BT $NAMFS $NAPKS $NAMKS " >> "$RDR/var/db/$NAMES"
			fi
		else
			if [ -z "${NAMESFL##*B*NAMES*}" ] # if USENAME is found in B*NAMES file
			then
 				OSTATS=($(grep -iE "(^|[^-])\b^$USENAME\b($|[^-])" "$RDR/var/db/$NAMES" | awk '{print $2" "$4" "$5" "$6}')) # get old statistics
				if [ "${OSTATS[0]}" \< "$TDATE" ] || [ "${OSTATS[1]}" \> "$BT" ] || [ "${OSTATS[2]}" \< "$NAMFS" ] || [ "${OSTATS[3]}" \< "$NAPKS" ] # lexicographic (greater than, less than) comparison
				then
 					OSTATS=($(grep -iE "(^|[^-])\b^$USENAME\b($|[^-])" "$RDR/var/db/$NAMES" | awk '{print $2" "$4" "$5" "$6}')) # get old statistics
	 				printf "%s" "Replacing $USENAME $TDATE $DS $BT $NAMFS $NAPKS $NAMKS in ~/${RDR##*/}/var/db/$NAMES: "
					sed -i "/^$USENAME/d" "$RDR/var/db/$NAMES"
	 				printf "%s %s\\n" "$USENAME $TDATE $DS $BT $NAMFS $NAPKS $NAMKS " >> "$RDR/var/db/$NAMES"
				fi
			else
			_PRINTNAU_
			fi
		fi
		_ANAMESDB_
		_PRINTDONEN_
	fi
}

_PRINTDONEN_() {
	printf "DONE\\n"
	printf "\033]2;%sDONE\007" "Processing ~/${RDR##*/}/var/db/$NAMES: "
}

_PRINTNAU_ () { # printf message if USENAME is found in NAMES file
	printf "%s" "NOT adding $USENAME to ~/${RDR##*/}/var/db/$NAMES: $USENAME is already in file $NAMES: "
}

_PRINTPRN_() {
	printf "%s" "Processing ~/${RDR##*/}/var/db/$NAMES: "
	printf "\033]2;%sOK\007" "Processing ~/${RDR##*/}/var/db/$NAMES: "
}

_PRINTO_ () {
	printf "Available options for %s are: \\nENAMES \\nGNAMES \\nONAMES \\nPNAMES \\nQNAMES \\nTNAMES \\nUNAMES \\nZNAMES\\n" "${0##*/}"
	exit 14
}

if [ -z "${1:-}" ]
then
	_PRINTO_
fi
# names.sh EOF
