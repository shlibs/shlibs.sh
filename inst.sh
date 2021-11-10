#!/usr/bin/env sh
# Copyright 2020-2021 (c) all rights reserved by S D Rausty; See LICENSE
# File `inst.sh` is under development
#####################################################################
set -eu
_INST_() {
# check for neccessary commands: begin
COMMS="$1"
COMMANDR="$(command -v au)" || (printf "%s\\n\\n" "$STRING1")
COMMANDIF="${COMMANDR##*/}"
STRING1="COMMAND \`au\` enables rollback, available at https://wae.github.io/au/ IS NOT FOUND: Continuing... "
STRING2="Cannot update ~/${RDR##*/} prerequisite: Continuing..."
PKGS="$2"
_INPKGS_() {
if [ "$COMMANDIF" = au ]
then
au "$PKGS" || printf "%s\\n" "$STRING2"
else
apt install "$PKGS" || printf "%s\\n" "$STRING2"
fi
}
for COMMA in "$COMMS"
do
COMMANDP="$(command -v "$COMMA")" || printf "Command %s not found: Continuing...\\n" "$COMMA" # test if command exists
COMMANDPF="${COMMANDP##*/}"
if [ "$COMMANDPF" != "$COMMA" ]
then
printf "%s\\n" "Beginning buildAPKs \`$3\` setup:"
_INPKGS_
fi
done
# check for neccessary commands: end
}
# inst.sh EOF
