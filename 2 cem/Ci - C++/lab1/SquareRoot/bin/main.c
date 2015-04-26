/*
Вариант 2
Найти целую часть квадратного корня из целого числа n. 
0<=n<=10^9
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    unsigned long int n;            // предел типа: 4294967295 как раз подходит под условие
    unsigned long int halfN;            // переменная для вычисления корня по итерационной формуле Герона




    printf("Enter N to get a root:");
    scanf ("%ld", &n);
    halfN = n/2;
    int accur = 1;                         // данный параметр задаёт точность вычисленния
    for(accur = 1;accur<15;++accur){
            halfN=(halfN+n/halfN)/2;        // итерационная формула Герона
        }

    printf("%ld",halfN);
    return 0;
}
