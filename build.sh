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
nasm -f elf64 "$ROOT/vulpin.asm" -o "$ROOT/vulpin.o"
gcc -no-pie "$ROOT/vulpin.o" -o "$ROOT/vulpin"
chmod 755 "$ROOT/vulpin"
echo "Built full Vulpin interpreter: $ROOT/vulpin"
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"
ln -sf "$ROOT/vulpin" "$LOCAL_BIN/vulpin"
echo "Installed: $LOCAL_BIN/vulpin -> $ROOT/vulpin"
SYSTEM_BIN="/usr/local/bin"
if [ -w "$SYSTEM_BIN" ]; then
ln -sf "$ROOT/vulpin" "$SYSTEM_BIN/vulpin"
echo "Installed: $SYSTEM_BIN/vulpin -> $ROOT/vulpin"
elif command -v sudo >/dev/null 2>&1; then
if sudo -n ln -sf "$ROOT/vulpin" "$SYSTEM_BIN/vulpin" 2>/dev/null; then
echo "Installed: $SYSTEM_BIN/vulpin -> $ROOT/vulpin"
else
echo "note: could not update $SYSTEM_BIN/vulpin without a sudo prompt." >&2
echo "      run once manually: sudo ln -sf \"$ROOT/vulpin\" $SYSTEM_BIN/vulpin" >&2
fi
else
echo "note: $SYSTEM_BIN not writable and sudo not found; skipped." >&2
fi
echo "Done :)"
