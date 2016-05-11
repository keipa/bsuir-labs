#include <iostream>
#include <algorithm>
#include <string>
using namespace std;



int main()
{
	long long num = 0;
	long long save;
	string str;
	cin >> str;
	save = num;

	int  k = 0;
	int j = 0;
	long long next = 0;
	//while (num % 10 != 0)
	//{
	//	//v.insert(v.begin(), num % 10);
	//	num = (num - num % 10) / 10;
	//	++k;
	//}


	if (next_permutation(str.begin(), str.end())){
		cout << str;
	}
	else
	{
		cout << "-1";
	}



//	for (int i = k - 1; i >= 0; i--)
//	{
//
////		next += v[i] * pow(10, j);
//		++j;
//	}
//	if (next <= save){
//		cout << -1;
//
//	}
//	else
//	{
//		cout << next;
//	}
	return 0;

}