#!/usr/bin/env sh
#
# Compile and run a FASTO program.  This script should work on Linux, Mac, and
# Microsoft Windows with Cygwin <https://cygwin.com/>.
#
# The ars1_6.jar simulator must be in your Fasto "bin" directory, or you must
# export its location into the environment variable named RARS.
#
# If '-o' is given as the first argument, the program will be optimised.
#
# Usage: bin/compilerun.sh [-o] PROGRAM.fo

set -e # Exit on first error.

base_dir="$(dirname "$0")"

if [ $# -eq 0 ]; then
    echo "Usage: $0 [-o] PROGRAM.fo"
    exit 1
fi

if [ "$1" = -o ]; then
    flags=-o
    shift
else
    flags=-c
fi

prog_input="$1"

# Compile.
"$base_dir/../bin/fasto.sh" $flags "$1"

# Run
$base_dir/../bin/rars.sh "$(dirname "$prog_input")/$(basename "$prog_input" .fo).asm" 2> /dev/null
