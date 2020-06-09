

#include <stdio.h>


int main()
{
	int a,b,ang;
	int st[5][5], fi[5][5];

	printf("enter array characteristics AxB :\n");
	printf("enter  a:\n");
	scanf("%d", &a);
	printf("enter  b:\n");
	scanf("%d", &b);
	printf("Charachteristics...Done!\n");
	
	printf("Fill in the array:\n");
	for(int j = 0; j < b-1; j++){
		for(int i = 0; i < a-1; i++){
		scanf("%d", st[i][j]);
			for(int j1 = 0; j1 < b-1; j1++){
				for(int i1 = 0; i1 < a-1; i1++){
				printf("%d",st[i1][j1]);
				}
				printf("\n");
			}
			fi[i][j] = st[i][j];
		}
	}
	printf("Filling the array...Done!\n");

	printf("Enter Rotate Angle (rotation counterclockwise)\n");
	scanf("%d",&ang);
	ang = ang/90;
	ang = ang % 4;
	if (a!=0)
		{
		for(int k = 1; k < ang; ang++)
		for(int j = 0; j < b-1; j++)
		for(int i = 0; i < a-1; i++)
			fi[j][a-i+1] = st[i][j];
	}
	printf("Rotation...Done!\n");
	
	
	for(int j1 = 0; j1 = b-1; j1++){
		for(int i1 = 0; i1 = a-1; i1++){
				printf("%d",st[i1][j1]);
				}
			printf("\n");
		}

	return 0;
}

