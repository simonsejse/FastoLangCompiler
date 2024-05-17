#!/usr/bin/env sh

# First call bin/fasto.sh -c tests/{name}.fo to compile the Fasto program.
# Second call bin/rars.sh tests/{name}.asm to run the RARS simulator.
# you call it with bin/compilerun-noopt.sh tests/{name}
set -e # Die on first error.

base_dir="$(dirname "$0")"

# Determine location of executable. Does this work on all platforms?
if ! [ "$FASTO" ]; then
    FASTO="$base_dir/../Fasto/bin/Debug/net8.0/Fasto.dll"
    if [ "$(uname -o 2> /dev/null)" = "Cygwin" ]; then
        FASTO="$(cygpath -w "$FASTO")"
    fi
fi

# Verify that .NET is installed.
dotnet --version &> /dev/null || (echo "Could not find dotnet" && exit 1)

dotnet $FASTO -c "$1.fo"
bin/rars.sh "$1.asm"
