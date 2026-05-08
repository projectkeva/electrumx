#!/bin/bash
set -u
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

while "$SCRIPT_DIR/electrumx_server"; exitcode=$? && test $exitcode -eq 65;
do
    echo Attempting automatic electrumx_compact_history.
    "$SCRIPT_DIR/electrumx_compact_history"
    # exit on compaction failure
    if test $? -ne 0
    then
        exit 2
    fi
done
exit $exitcode
