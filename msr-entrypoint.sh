#!/bin/sh

set -e

args="$@"

echo Attemping to enable MSR mod...
randomx_boost.sh || true

echo "xmrig" "$@"
exec "xmrig" "$@"
