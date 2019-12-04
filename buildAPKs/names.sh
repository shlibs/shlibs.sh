#!/bin/env sh
# Copyright 2019 (c)  all rights reserved by S D Rausty;  see LICENSE  
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

_DOBNAMES_ () {
	if [ -z "${NAMESFL##*B*NAMES*}" ] 
	then 
		: # printf "%s %s\\n" "$USENAME $DS $BT $NAMFS $NAPKS" "${0##*/}"
# 		if ! grep -iw "$USENAME\ $DS\ $BT\ $NAMFS\ $NAPKS" "$RDR/var/db/$NAMES" 1>/dev/null # USENAME, DS, BT, NAMFS and NAPKS is not found in NAMES file 
# 		then # add USENAME, DS, BT, NAMFS and NAPKS to NAMES file
# 			printf "%s %s\\n" "$USENAME $DS $BT $NAMFS $NAPKS"
# 		else
# 			: # 			sed -i "$USENAME\ $DS\ $BT\ $NAMFS\ $NAPKS/d" "$RDR/var/db/$NAMES"
# 		fi
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
		if ! grep -iw "$USENAME" "$RDR/var/db/$NAMES" 1>/dev/null # USENAME is not found in NAMES file
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
	if ! grep -iw "$NAMES" "$JDR/var/conf/NAMES.db" 1>/dev/null # NAMES is not found in NAMES.db
	then # add USENAME, DS, BT, NAMFS and NAPKS to NAMES file
		_PRINTPRN_ 
		if ! grep -iw "$USENAME" "$RDR/var/db/$NAMES" 1>/dev/null # USENAME is not found in NAMES file 
		then # add USENAME, DS, BT, NAMFS and NAPKS to NAMES file
			BT="$(( $(date +%s)-$ST ))" # calculate build time
			DS=0
			for SIZE in $(ls -al "$JDR"/*tar.gz | awk '{print $5}') 
			do # calculate download size
				DS=$((DS+SIZE))
			done 
			if [[ -f "$JDR/var/conf/NAMFS.db" ]]
			then
				NAMFS="$(cat $JDR/var/conf/NAMFS.db)" # number of AndroidManifest.xml files found
			else
				NAMFS=0
			fi
			if [ -z "${NAMESFL##*GNAMES*}" ] 
			then 
				printf "%s" "Adding $USENAME $NAPKS to ~/${RDR##*/}/var/db/$NAMES: "
				printf "%s %s\\n" "$USENAME $NAPKS" >> "$RDR/var/db/$NAMES" 
			else
				printf "%s" "Adding $USENAME $DS $BT $NAMFS $NAPKS to ~/${RDR##*/}/var/db/$NAMES: "
				printf "%s %s\\n" "$USENAME $DS $BT $NAMFS $NAPKS" >> "$RDR/var/db/$NAMES" 
			fi
		else # printf message if USENAME is found in NAMES file
			printf "%s" "NOT adding $USENAME to ~/${RDR##*/}/var/db/$NAMES: $USENAME is already in file $NAMES: "
		fi
		_DOBNAMES_ 
		_ANAMESDB_ 
		_PRINTDONEN_ 
	fi
}

_PRINTDONEN_() {
	printf "DONE\\n"
	printf "\033]2;%sDONE\007" "Processing ~/${RDR##*/}/var/db/$NAMES: "
}

_PRINTPRN_() {
	printf "%s" "Processing ~/${RDR##*/}/var/db/$NAMES: "
	printf "\033]2;%sOK\007" "Processing ~/${RDR##*/}/var/db/$NAMES: "
}

_PRINTO_ () {
	printf "Available options for %s are: \\nCNAMES \\nENAMES \\nGNAMES \\nONAMES \\nPNAMES \\nQNAMES \\nTNAMES \\nUNAMES \\nZNAMES\\n" "${0##*/}" 
	exit 14
}

if [ -z "${1:-}" ]
then
	_PRINTO_ 
fi
# names.sh EOF
