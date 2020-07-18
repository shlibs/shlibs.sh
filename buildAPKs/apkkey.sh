#!/usr/bin/env sh
# Copyright 2020 (c) all rights reserved by S D Rausty; See LICENSE
# File `apkkey.sh` is under development
#####################################################################
set -eu 
RDR="$HOME/buildAPKs"		# define root directory
. "$RDR/scripts/sh/shlibs/buildAPKs/inst.sh"
_INST_ "openssl" "openssl-tool" "apkkey.sh" 
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out request.pem
openssl x509 -req -days 9999 -in request.pem -signkey key.pem -out certificate.pem
openssl pkcs8 -topk8 -outform DER -in key.pem -inform PEM -out key.pk8 -nocrypt
# apkkey.sh EOF
