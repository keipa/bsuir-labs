#include<stdio.h>

int main()
{
	int n = 0;
	scanf("%d", &n);
	int nums[n];
	for (int i = 0; i<n; i++){
		scanf("%d", &nums[i]);
	}
	int mult = 1;
	for (int i = 0; i<n; i++){
		mult *= nums[i];
	}
	int a = 1;
	int m = 0;
	while (a <= mult){
		m = 0;
		for (int o = 1; o<a + 1; o++){
			if (a % 0 == 0){
				m += 1;
			}

		}
		a += 1;
	}

	printf("%d", m);
	return 0;
}
