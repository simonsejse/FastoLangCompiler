#!/usr/bin/env bash
#
# Run all tests.
#
# Use -o to optimise the test programs before compiling them.
# Use -i to interpret the test programs instead of compiling them.
#
# You can just run this script with no arguments.  If you want to run
# tests from a certain directory, specify that as the last argument.
# For example, if you are in the root directory, and want to run the
# tests in 'my_tests_dir` with optimisations enabled, you can run:
#
#   $ ./bin/runtests.sh -o my_tests_dir
#
# Test programs (those ending with '.fo') are given their corresponding
# '.in' files as standard in when running, and are expected to produce
# the contents of the corresponding '.out' files, or the error of the
# corresponding '.err' files.  If no corresponding '.in' file exists,
# the program is expected to fail at compile time.
#
# The rars1_6.jar simulator must be in your Fasto "bin" directory, or
# you must export its location into the environment variable named RARS,
# unless you're using the '-i' option, in which case RARS is not used.
#
# If no argument is given, the script will run the tests in the current
# directory; otherwise it will use the first argument as a directory,
# and run the tests in that directory.
#
# Authors through the ages:
#   Troels Henriksen <athas@sigkill.dk>.
#   Rasmus Wriedt Larsen
#   Mathias Grymer <mathias1292@gmail.com>
#   Niels G. W. Serup <ngws@metanohi.name>
#   Andrzej Filinski <andrzej@di.ku.dk>

set -e # Die on first error.

base_dir="$(dirname "$0")"
fasto="$base_dir/../bin/fasto.sh"
rars="$base_dir/../bin/rars.sh"

# Determine fasto command-line flags.
if [ "$1" = -o ]; then
    flags=-o
    shift
elif [ "$1" = -i ]; then
    flags=''
    shift
else
    flags=-c
fi

# Find the directory containing the test programs.
tests_dir="$1"
if ! [ "$tests_dir" ]; then
    tests_dir="$base_dir/../tests"
fi
tests_dir="$(echo "$tests_dir" | sed 's/\/*$//')"

# Remove all whitespace and NUL bytes when comparing results, because
# Rars and the interpreter puts different amounts -- and to handle
# Windows/OSX/Unix line ending differences.
fix_whitespace() {
    cat "$1" | tr -d '\000' | tr -d ' \t\n\r\f' 1>&1
}

check_equal() {
    if [ -f $tests_dir/$OUTPUT ]; then

        EXPECTED=$(fix_whitespace "$tests_dir/$OUTPUT")
        ACTUAL=$(fix_whitespace "$TESTOUT")
        if [ "$EXPECTED" = "$ACTUAL" ]; then
            rm -f $TESTOUT
        else
            echo "Output for $PROG does not match expected output."
            echo "Compare $TESTOUT and $tests_dir/$OUTPUT."
            return 1
        fi
    fi
}

# make -C "$base_dir/.."

file_len=0
for FO in $tests_dir/*fo; do
    L=$(basename "$FO")
    if ((${#L} > $file_len)); then
        file_len=${#L}
    fi
done
file_len=$(($file_len+4))

echo
if [ "$flags" = "" ]; then
  echo "=== Running Fasto test programs (interpreted) ==="
elif [ "$flags" = "-c" ]; then
  echo "=== Running Fasto test programs (compiled) ==="
elif [ "$flags" = "-o" ]; then
  echo "=== Running Fasto test programs (compiled, with optimizations) ==="
fi
echo
for FO in $tests_dir/*fo; do
    FO=$(basename "$FO")
    PROG=$(echo $FO|sed 's/.fo$//')
    INPUT=$(echo $FO|sed 's/fo$/in/')
    OUTPUT=$(echo $FO|sed 's/fo$/out/')
    ERROUT=$(echo $FO|sed 's/fo$/err/')
    ASM=$(echo $FO|sed 's/fo$/asm/')
    TESTOUT=$tests_dir/$OUTPUT-testresult

    if [ -f $tests_dir/$INPUT ]; then
        # Is positive test.
        echo -n "Testing"
        printf "%*s" $file_len " $FO:  "
        if [ "$flags" ]; then
            # Compile.
            if $fasto $flags $tests_dir/$PROG; then
                $rars $tests_dir/$ASM < $tests_dir/$INPUT > $TESTOUT 2>/dev/null
                if check_equal; then
                    echo -e "\033[92mSuccess.\033[0m"
                else
                    echo -e "\033[91mExecution error.\033[0m"
                fi
            else
                echo -e "\033[91mCompilation error.\033[0m"
            fi
        else
            # Interpret.
            cat $tests_dir/$INPUT | $fasto -r $tests_dir/$PROG | grep -v "Result of 'main'" > $TESTOUT 2>&1
            if check_equal; then
                echo -e "\033[92mSuccess.\033[0m"
            else
                echo -e "\033[91mInterpretation error.\033[0m"
            fi
        fi
    else
        # Is negative test.
        echo -n "Testing"
        printf "%*s" $file_len "$FO:  "
        if $fasto -c $tests_dir/$PROG > $TESTOUT 2>&1; then
            echo -e "\033[91mCompiled but should result in compile error.\033[0m"
        elif [ -f $tests_dir/$ERROUT ]; then
            EXPECTED=$(fix_whitespace $tests_dir/$ERROUT)
            ACTUAL=$(fix_whitespace $TESTOUT)
            if [ "$EXPECTED" = "$ACTUAL" ]; then
                rm -f $TESTOUT
                echo -e "\033[92mSuccess (compile error).\033[0m"
            else
                echo -e "\033[91mThe error for $PROG does not match the expected error.  Compare $TESTOUT and $tests_dir/$ERROUT.\033[0m"
            fi
        else
            echo -e "\033[92mSuccess (compile error).\033[0m"
        fi
    fi
done
