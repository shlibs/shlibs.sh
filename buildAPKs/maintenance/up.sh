#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty;  See LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Run to update ~/buildAPKs and modules to the newest version
#####################################################################
set -eu 
RDR="$HOME/buildAPKs" # define root directory
cd "$RDR" # change directory to root directory
git pull # run ` git pull ` to update the the local copy of git repository https://github.com/BuildAPKs/buildAPKs to the newest version 
rm -f scripts/bash/shlibs/.git scripts/sh/shlibs/.git  # remove automatically generated submodule .git files
sleep 0.42 # intensify latency support on fast networks;  ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` shows additional latency usage of ` sleep ` in BuildAPKs once BuildAPKs is installed
git submodule update --init --recursive --remote scripts/bash/shlibs # ` git submodule help ` and https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information.  The source code for this book is hosted at https://github.com/progit/progit2
sleep 0.42 # increase latency support on fast networks;  See ` grep -hC 4 -r sleep ~/buildAPKs/scripts ` for complementary latency applications of ` sleep ` when BuildAPKs is setup.  You can use https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/scripts/bash/init/setup.buildAPKs.bash to set ~/buildAPKs up on device with ` curl -OL https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/scripts/bash/init/setup.buildAPKs.bash ; bash setup.buildAPKs.bash `.
git submodule update --init --recursive --remote scripts/sh/shlibs # ` git submodule help ` and https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information.
# up.sh EOF
