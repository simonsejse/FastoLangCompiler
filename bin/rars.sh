#!/usr/bin/env bash

set -e # Die on first error.

base_dir="$(dirname "$0")"

# Determine location of RARS.
if ! [ "$RARS" ]; then
    RARS="$base_dir/../bin/rars1_6.jar"
    if [[ $(uname -o 2> /dev/null) = "Cygwin" ]]; then
        RARS="$(cygpath -w "$RARS")"
    fi
fi

# Verify that Java is installed.
java -version &> /dev/null || (echo "Could not find java" && exit 1)

java -jar "$RARS" nc "$@"
