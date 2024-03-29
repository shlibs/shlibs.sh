#!/usr/bin/env sh
# Copyright 2019-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# adds directory in RDR from arguments
################################################################################
set -eu

_MKDIRS_ () { # create directories from arguments
ARGS="$@"
NAMESFL=""
for ARG in $ARGS
do
NAMESFL="$NAMESFL $ARG"
done
for DIR in $NAMESFL
do
if [ ! -e  "$RDR/$DIR" ] # DIR does not exist in RDR
then # create directory DIR in RDR
mkdir -p "$RDR/$DIR" || printf "%s" "Signal generated at mkdir -p $RDR/$DIR ${0##*/} mkdirs.sh : Continuing : "
fi
done
}

_MKRDIRS_ () { # create list from arguments
ARGS="$@"
NAMESFL=""
for ARG in $ARGS
do
NAMESFL="$NAMESFL $ARG"
done
for DIR in $NAMESFL
do
if [ ! -e  "$RDR/$DIR" ] # DIR does not exist in RDR
then # create directory DIR in RDR
mkdir -p "$RDR/$DIR" || printf "%s" "Signal generated at mkdir -p $RDR/$DIR ${0##*/} mkdirs.sh : Continuing : "
fi
done
}
# mkdirs.sh EOF
