#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;

template<typename It>

bool next_permutation(It begin, It end)
{
	if (begin == end)
		return false;

	It i = begin;
	++i;
	if (i == end)
		return false;

	i = end;
	--i;

	while (true)
	{
		It j = i;
		--i;

		if (*i < *j)
		{
			It k = end;

			while (!(*i < *--k))
				/* pass */;

			iter_swap(i, k);
			reverse(j, end);
			return true;
		}

		if (i == begin)
		{
			reverse(begin, end);
			return false;
		}
	}
}

int main()
{
	int num;
	int save;
	cin >> num;
	save = num;
	vector <int> v;
	int  k = 0;
	int j = 0;
	int next = 0;
	while (num % 10 != 0)
	{
		v.insert(v.begin(), num % 10);
		num = (num - num % 10) / 10;
		++k;
	}


	::next_permutation(v.begin(), v.end());



	for (int i = k - 1; i >= 0; i--)
	{

		next += v[i] * pow(10, j);
		++j;
	}
	if (next <= save){
		cout << -1;

	}
	else
	{
		cout << next;
	}


}
