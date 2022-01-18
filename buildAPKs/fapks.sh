#!/usr/bin/env sh
# Copyright 2019-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds logins to $RDR/var/db/BNAMES file if APKs were built
################################################################################
set -eu
_APKBC_() {
	printf "%s\\n" "Searching for built APKs, and calculating build size:"
	APKSN=($(find "$JDR" -type f -name "*.apk" | cut -f9-99 -d"/"))
	DS="$(du -bhs $JDR | awk '{print $1}')"
	NAPKS="${#APKSN[@]}"
	: ${APKSN:=0}
	printf "%s\\n" "Found $NAPKS built APKs, and build size is $DS."
	if [ "$NAPKS" -ne 1 ]
	then
		printf "%s" "Writing $NAPKS APKs built to $JDR/var/conf/NAPKS.db  "
		printf "%s" "Writing $APKSN APKs built to $JDR/var/conf/APKSN.db  "
	else
		printf "%s" "Writing $NAPKS APK built to $JDR/var/conf/NAPKS.db  "
		printf "%s" "Writing $APKSN APK built to $JDR/var/conf/APKSN.db  "
	fi
	printf "%s\\n" "$APKSN" > "$JDR/var/conf/APKSN.db"
	printf "%s\\n" "$DS" > "$JDR/var/conf/DS.db"
	printf "%s\\n" "$NAPKS" > "$JDR/var/conf/NAPKS.db"
	if [ "$NAPKS" -gt 999 ] # USENAME built more than 999 APKs
	then # add USENAME NAPKS pair to B1000NAMES
		_NAMESMAINBLOCK_ B1KNAMES log/B1KNAMESNAPKs
	fi
	if [ "$NAPKS" -gt 99 ] # USENAME built more than 99 APKs
	then # add USENAME NAPKS pair to B100NAMES
		_NAMESMAINBLOCK_ B100NAMES log/B100NAMESNAPKs
	fi
	if [ "$NAPKS" -gt 9 ] # USENAME built more than 9 APKs
	then # add USENAME NAPKS pair to B10NAMES
		_NAMESMAINBLOCK_ B10NAMES log/B10NAMESNAPKs
	fi
	if [ "$NAPKS" -gt 0 ] # USENAME built more than 0 APKs
	then # add USENAME NAPKS pair to BNAMES
		_NAMESMAINBLOCK_ BNAMES log/BNAMESNAPKs
	fi
	if [ "$NAPKS" -eq 0 ] # USENAME's APKs were not built
	then
		if [[ -n $(find "$JDR" -type f -name "AndroidManifest.xml") ]] # AndroidManifest.xml files are found
		then # add USENAME to YNAMES
			_NAMESMAINBLOCK_ YNAMES
		else # add USENAME to ZNAMES
			_NAMESMAINBLOCK_ ZNAMES
		fi
	fi
}
# fapks.sh EOF
