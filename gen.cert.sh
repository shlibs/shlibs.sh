#!/usr/bin/env sh
# Copyright 2017-2022 (c) all rights reserved by S D Rausty;  Please see LICENSE
# See LICENSE for details https://buildapks.github.io/docsBuildAPKs/
################################################################################
set -eu
[ -z "${RDR:-}" ] && RDR="$HOME/buildAPKs"
. "$RDR/scripts/sh/shlibs/inst.sh"
_INST_ "openssl" "openssl-tool" "${0##*/} gen.cert.sh"
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out request.pem
openssl x509 -req -days 9999 -in request.pem -signkey key.pem -out certificate.pem
openssl pkcs8 -topk8 -outform DER -in key.pem -inform PEM -out key.pk8 -nocrypt
# gen.cert.sh EOF
