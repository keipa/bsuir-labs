#include <stdio.h>
#include <math.h>


int main()
{
int count = 0;
int toswapbor = 1;
int start[2];
scanf("%d",&start[0]);
scanf("%d",&start[1]);
int mas[start[0]];
for (int i = 0;i < start[0];i++){
    scanf("%d",&mas[i]);
}
for (int toswapbor = 0; toswapbor<start[1]; toswapbor++){
for (int i = 1;i <= start[1];i++){
        if(toswapbor+i+1 > start[0]) break;
	if(mas[i] != mas [toswapbor+i+1]){
	++count;
	}
}
}
printf(count);



return 0;
}
