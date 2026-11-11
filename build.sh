#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
command -v nasm >/dev/null 2>&1 || {
echo 'error: NASM is required.' >&2
exit 127
}
command -v gcc >/dev/null 2>&1 || {
echo 'error: gcc is required for linking.' >&2
exit 127
}
nasm -f elf64 "$ROOT/vulpin.asm" -o "$ROOT/vulpin-core.o"
gcc -no-pie "$ROOT/vulpin-core.o" -o "$ROOT/vulpin-core"
chmod 755 "$ROOT/vulpin-core"
echo "Built full Vulpin interpreter: $ROOT/vulpin-core"
