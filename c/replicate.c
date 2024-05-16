/*
DISCLAIMER:
    This C file demonstrates how to replicate a boolean array with a given length. 
    This is to help visualize how it looks in low level for our CodeGen.fs to make it
    easier to generate low level intermediate representation / risc-v code.  
*/

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


void printResult(bool* boolptr, int length){
    for(int i = 0; i < length; i++){
        printf("%d ", *(boolptr + i));
    }
    printf("\n");
}

int main(){
    int n = 10; 
    bool a = true;

    bool* bools = malloc(sizeof(a) * n); 

    for(int i = 0; i < n; i++){
        *(bools + i) = a; 
    }

    printResult(bools, n);
    free(bools);
    return 0; 
} 