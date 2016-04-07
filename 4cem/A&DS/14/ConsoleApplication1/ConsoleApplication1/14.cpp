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
	cin >> num;
	vector <int> v;
	while (num % 10 != 0){
		v.push_back(num % 10);
		num = (num - num % 10) / 10;
	}









	do
	{
		for (int i = 0; i < 4; i++)
		{
			cout << v[i] << " ";
		}
		cout << endl;
	} while (::next_permutation(v.begin(), v.end()));
}
