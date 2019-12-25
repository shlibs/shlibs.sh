#!/usr/bin/env sh
# Updates https://github.com/BuildAPKs/buildAPKs and core submodules.
# Copyright 2019 (c)  all rights reserved by S D Rausty;  See LICENSE  
#####################################################################
set -eu 

_PESTRG_() {
	printf "%s\\n" "$ESTRING"
}

ESTRING="Warning ${0##*/} up.sh; Continuing..."
RDR="$HOME/buildAPKs" # define root directory.
cd "$RDR"	# change directory to root directory.
git pull	# run ` git pull ` to update the local copy of remote git repository https://github.com/BuildAPKs/buildAPKs to the newest version on device. 

sleep 0.$(shuf -i 24-72 -n 1) # add device latency support;  Commands like this script can request many read write operations.  This command causes the script to wait for a short pseudo random period of time.  This can ease excessive device latency when running these build scripts.

rm -f opt/db/.git scripts/bash/github/.git scripts/bash/shlibs/.git scripts/sh/shlibs/.git || printf "%s\\n" "$ESTRING" # remove automatically generated submodule .git files which were created through the process of cloning and updating git repositories as submodules.

git submodule update --init --recursive --remote opt/db || _PESTRG_ # The command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information about git submodules.

sleep 0.$(shuf -i 24-72 -n 1) # enhance network latency support on fast networks;  ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` shows additional latency usage of ` sleep ` in BuildAPKs once BuildAPKs is installed.  Commands like this script, and ` build.github.bash ` can send many requests.  This can lead to network packet collisions on a fast device that is connected to a fast network, which in turn causes excessive network latency.

git submodule update --init --recursive --remote scripts/bash/github || _PESTRG_ 
sleep 0.$(shuf -i 24-72 -n 1) # increase network latency support on fast networks;  See ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` for complementary latency applications of ` sleep ` when BuildAPKs is installed.  You can use https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/setup.buildAPKs.bash to set ~/buildAPKs up on device with ` curl -OL https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/setup.buildAPKs.bash ; bash setup.buildAPKs.bash `.  It appears that a little sleep can go a long way in reducing network collisions on fast networks.

git submodule update --init --recursive --remote scripts/bash/shlibs || _PESTRG_
sleep 0.$(shuf -i 24-72 -n 1)
git submodule update --init --recursive --remote scripts/sh/shlibs || _PESTRG_
# up.sh EOF
