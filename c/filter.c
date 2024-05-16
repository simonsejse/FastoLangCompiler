// filter in c
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#define ARR_SIZE 10

bool greaterThan5(int x)
{
    return x > 5;
}

int main()
{
    int a[ARR_SIZE] = {0};
    for (int i = 0; i < ARR_SIZE; i++)
    {
        a[i] = i;
    }
    // filter using greaterThan5
    int count = 0;
    for (int i = 0; i < ARR_SIZE; i++)
    {
        if (greaterThan5(a[i]))
        {
            count++;
        }
    }
    int *result = malloc(sizeof(int) * count);
    int j = 0;
    for (int i = 0; i < ARR_SIZE; i++)
    {
        if (greaterThan5(a[i]))
        {
            result[j] = a[i];
            j++;
        }
    }
}
