#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
using namespace std;
typedef vector<int> vec;


long long mod = 1000000007;
int n, k, pos1 = 0, pos2 = 0, negative = 0;

long long res = 1;

void print_res(long long res) {
	if (res < 0) {
		cout << res + mod;
	}
	else {
		cout << res;
	}
}

void QuickSort(vec &a, int l, int r) {
	int i = l, j = r, pivot = abs(a[l + ((r - l) >> 1)]);
	do {
		while (abs(a[i]) < pivot) i++;
		while (abs(a[j]) > pivot) j--;
		if (i <= j) {
			int temp = a[i];
			a[i++] = a[j];
			a[j--] = temp;
		}
	} while (i < j);
	if (l < j) QuickSort(a, l, j);
	if (i < r) QuickSort(a, i, r);
}


long long max4(long long pos, long long neg, long long kodd, long long keven) {
	if (pos >= neg && pos >= kodd && pos >= keven) return pos;
	if (neg >= pos && neg >= kodd && neg >= keven) return neg;
	if (kodd >= pos && kodd >= pos && kodd >= keven) return kodd;
	if (keven >= pos && keven >= neg && keven >= kodd) return keven;
}

int main()
{
	vec original(100002, 0);
	vec index_arr(100002, 0);
	cin >> n >> k;


	for (int i = 1; i <= n; i++) cin >> original[i];
	QuickSort(original, 1, n); // sorting
	int k_2 = 0;

	long long int positive = 1;
	long long int negative = 1;
	long long int kodd = 1;
	long long int keven = 1;

	for (int i = n; i > n - k; i--) positive *= original[i];
	for (int i = 1; i <= k; i++) negative *= original[i];
	if (k % 2 == 0) {
		k = k / 2;
		for (int i = n; i > n - k; i--) kodd *= original[i];
		for (int i = 1; i <= k; i++) kodd *= original[i];
		keven = kodd;
	}
	else
	{
		k_2 = k / 2;
		for (int i = n; i > n - k_2; i--) kodd *= original[i];
		k = k - k_2;
		for (int i = 1; i <= k; i++) kodd *= original[i];

		for (int i = n; i > n - k; i--) keven *= original[i];

		for (int i = 1; i <= k_2; i++) keven *= original[i];

	}


	print_res(max4(positive, negative, kodd, keven) % mod);
	cin >> res;
	return 0;
}