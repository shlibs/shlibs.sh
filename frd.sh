#!/bin/env sh
set -eu
g=$PWD
h=$(ls)
for i in $h
do
	cd $i && find . -maxdepth 1 -type d -exec rm -rf {} \;
	echo $PWD
	cd $g
done
# frd.sh EOF
