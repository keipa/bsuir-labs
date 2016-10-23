// ConsoleApplication1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

using namespace std;

int main()
{
	int sum = 0;
	int i, j, cnt;

	for (i = 2; i < 100000000; ++i) {
		cnt = 0;
		for (j = 1; j <= i; ++j) {
			if (!(i % j))
				++cnt;
		}
		if (cnt == 2) {
			sum += i;
			
			
		}
	}
	printf("%d", sum);

	return 0;
}