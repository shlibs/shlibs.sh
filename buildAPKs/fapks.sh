#!/usr//bin/env sh
# Copyright 2019 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds logins to ~/$RDR/var/db/BNAMES file if APKs were built
#####################################################################
set -eu
_APKBC_() {
	NAPKS=$(find "$JDR" -type f -name "*.apk" | wc -l) 
	printf "%s" "Writing $NAPKS built APKs found to $JDR/var/conf/NAPKS.db  "
	printf "%s\\n" "$NAPKS" > "$JDR/var/conf/NAPKS.db" 
	if [ "$NAPKS" -gt 999 ] # USENAME built more than 999 APKs
	then # add USENAME NAPKS pair to B1000NAMES 
		_NAMESMAINBLOCK_ B1000NAMES log/B1000NAMESNAPKs
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
		then # add USENAME to RNAMES
			_NAMESMAINBLOCK_ RNAMES 
		else # add USENAME to ZNAMES
			_NAMESMAINBLOCK_ ZNAMES 
		fi
	fi
}
# fapks.sh EOF
