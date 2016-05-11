#include <iostream>
#include <algorithm>
#include <utility>
#include <cmath>

using namespace std;

const int MAXN = 1e6 + 5;
const int module = 1e9 + 7;
long long arr[MAXN];


void print_res(long long res) {
	if (res < 0) {
		cout << res + module;
	}
	else {
		cout << res;
	}
}

int main(){
	int n, k;
	cin >> n >> k;
	for (int i = 0; i < n; i++){
		cin >> arr[i];
	}

	sort(arr, arr + n);
	int index_l = 0;
	int index_r = n - 1;
	long long pl;
	long long pr;
	long long left_border;
	long long right_border;
	long long currrent_mul = 1ll;
	bool negative_is_greater = false;
	if (k % 2){
		currrent_mul = (1ll* currrent_mul * arr[index_r--]) % module;
		k--;
	}

	while (k){
		left_border = 1ll*arr[index_l] * arr[index_l + 1];



		right_border = 1ll*arr[index_r] * arr[index_r - 1];


		negative_is_greater = left_border >= right_border;

		left_border %= module;
		right_border %= module;

		pl = (1ll * currrent_mul * left_border) % module;
		pr = (1ll * currrent_mul * right_border) % module;

		if (currrent_mul < 0){ //max in arr < 0 and k is nechet (the same but  vice versa)
			if (negative_is_greater){
				currrent_mul = pr;
				index_r -= 2;
			}
			else
			{
				currrent_mul = pl;
				index_l += 2;
			}
		}
		else{//standart case
			if (!negative_is_greater){
				currrent_mul = pr;
				index_r -= 2;
			}
			else{
				currrent_mul = pl;
				index_l += 2;
			}
		}

		k -= 2;
	}

	cout << (currrent_mul + module) % module << endl;

	cin >> n;
	return 0;
}