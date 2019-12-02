#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty;  See LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Updates ~/buildAPKs and submodules to the newest available version.
# Use cat ~/buildAPKs/.gitmodules to see the installed submodules.
# ~/buildAPKs/build.buildAPKs.modules.bash installs submodules.
#####################################################################
set -eu 
RDR="$HOME/buildAPKs" # define root directory

cd "$RDR"	# change directory to root directory

git pull	# run ` git pull ` to update the the local copy of remote git repository https://github.com/BuildAPKs/buildAPKs to the newest version on device 

rm -f scripts/bash/shlibs/.git scripts/sh/shlibs/.git	# remove automatically generated submodule .git files, which were created through the process of cloning and updating git repositories

sleep 0.$(shuf -i 24-72 -n 1)	# intensify latency support on fast networks;  ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` shows additional latency usage of ` sleep ` in BuildAPKs once BuildAPKs is installed

git submodule update --init --recursive --remote scripts/bash/shlibs	# The command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information.  The source code for this book is hosted at https://github.com/progit/progit2

sleep 0.$(shuf -i 24-72 -n 1) # increase latency support on fast networks;  See ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` for complementary latency applications of ` sleep ` when BuildAPKs is setup.  You can use https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/scripts/bash/init/setup.buildAPKs.bash to set ~/buildAPKs up on device with ` curl -OL https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/scripts/bash/init/setup.buildAPKs.bash ; bash setup.buildAPKs.bash `.  It appears that a little sleep can go a long way in reducing network collisions.

git submodule update --init --recursive --remote scripts/sh/shlibs	# The command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information.
# up.sh EOF
