#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
#####################################################################
set -eu 
RDR="$HOME/buildAPKs"
cd "$RDR"
git pull
rm -f scripts/bash/shlibs/.git
rm -f scripts/sh/shlibs/.git
sleep 0.2
git submodule update --init --recursive --remote scripts/bash/shlibs
sleep 0.2
git submodule update --init --recursive --remote scripts/sh/shlibs
# up.sh EOF
