#include <iostream>
#include <algorithm>
#include <string>
using namespace std;


int main()
{
	int n;
	//1021
	//1031
	//1033
	cin >> n;


	long long big = 1087388483;
	bool verify_b = false;
	long long for_n[3] = { 1021 * 1033, 1033 * 1031, 1031 * 1021 };
	bool verify_n [3]= { false, false, false };
	long long for_s[3] = { 1021, 1033, 1031 };
	bool verify_s[3] = { false, false, false };



	long long current;
	for(int i = 0; i < n; i++){
		cin >> current;
		if (current == big){
			verify_b = true;
		}
		if (current == for_n[0]){
			verify_n[0] = true;
		}
		if (current == for_n[1]){
			verify_n[1] = true;
		}
		if (current == for_n[2]){
			verify_n[2] = true;
		}
		if (current == for_s[0]){
			verify_s[0] = true;
		}
		if (current == for_s[1]){
			verify_s[1] = true;
		}
		if (current == for_s[2]){
			verify_s[2] = true;
		}
	}
	if (verify_b || (verify_s[0] && verify_s[1] && verify_s[2]) || (verify_n[0] && verify_s[2]) || (verify_n[1] && verify_s[0]) || (verify_n[2] && verify_s[1]) ){
		cout << "YES";
	}
	else
	{
		cout << "NO";
	}
	return 0;
}