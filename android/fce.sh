#!/usr/bin/env sh
# Copyright 2020-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# This file  ` fce.sh `  checks whether external storage is writable.
################################################################################
set -eu
SP=$(ls /storage)
SDD=$(printf $SP|grep [[:digit:]])
ETP="/storage/$SDD/Android/data/com.termux/"
[ -w $ETP ] && printf true || printf false
# fce.sh EOF
