#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
#####################################################################
set -eu 
RDR="$HOME/buildAPKs" # define root directory
cd "$RDR" # change directory to root directory
git pull
rm -f scripts/bash/shlibs/.git scripts/sh/shlibs/.git  # remove .git files
sleep 0.42 # added for network latency support on fast networks; see ` grep -hC 4 -r ~/buildAPKs/scripts ` for more applications when installed.
git submodule update --init --recursive --remote scripts/bash/shlibs # ` git submodule help ` has more information
sleep 0.42 # added network latency support on fast networksnetworks; see ` grep -hC 4 -r ~/buildAPKs/scripts ` for more allocations when setup.
git submodule update --init --recursive --remote scripts/sh/shlibs # ` git submodule help ` has more information
# up.sh EOF
