#!/bin/bash

# Clean up test files (all .asm and .out-testresult)

echo "Do you want to delete all .asm (y/n)"
read answer

if [ "$answer" == "2y" ]; then
    rm -f tests/*.asm
    rm -f tests/*.out-testresult
    echo "[CLEAN]: All .asm and .out-testresult files are deleted"
    exit
fi

if [ "$answer" == "y" ]; then
    rm -f tests/*.asm
    echo "[CLEAN]: All .asm files are deleted"
fi

echo "Do you want to delete all .out-testresult (y/n)"
read answer
if [ "$answer" == "y" ]; then
    rm -f tests/*.out-testresult    
    echo "[CLEAN]: All .out-testresult files are deleted"
fi



