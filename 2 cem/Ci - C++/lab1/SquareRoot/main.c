/*
Variation 2
Find the integer part of the square root of an integer n.
0 <= n <= 10^9
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    const int MAX_ACCURATE = 15;
    unsigned long int n;                // limit types: 4294967295 just fit condition.
    unsigned long int halfN;            // Variable to calculate the root for Methods of computing square roots.
    int accur = 1;                     // This parameter specifies the accuracy of calculations.

    printf ("Enter N to get a root:");
    scanf ("%ld", &n);
    halfN = n / 2;

    for (accur = 1; accur < MAX_ACCURATE; ++accur)  {
            halfN = (halfN + n / halfN) / 2;        // Methods of computing square roots using Gerone
        }

    printf ("%ld", halfN);
    return 0;
}
