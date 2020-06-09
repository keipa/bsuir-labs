#include <iostream>


using namespace std;

long long int how_rise = 0;

int CheckStack(int *stack, int ver_index) {

	if (ver_index >= 2) {
		if (stack[ver_index - 1] < stack[ver_index] && stack[ver_index - 2] < stack[ver_index]) {
			how_rise += stack[ver_index - 2] - stack[ver_index - 1];
			stack[ver_index - 1] = stack[ver_index];
			ver_index -= 1;
			ver_index = CheckStack(stack, ver_index);
		}
		else if (stack[ver_index - 1] < stack[ver_index] && stack[ver_index - 2] > stack[ver_index])
		{
			how_rise += stack[ver_index] - stack[ver_index - 1];
			stack[ver_index - 1] = stack[ver_index];
			ver_index -= 1;
		}
	}
	else if (ver_index == 1)
	{
		if (stack[ver_index - 1] < stack[ver_index])
		{
			how_rise += stack[ver_index] - stack[ver_index - 1];
			stack[ver_index - 1] = stack[ver_index];
			ver_index -= 1;
		}
	}
	return ver_index;


}
void CollapseStack(int *stack, int ver_index) {
	int go_down = ver_index - 1;
	while (go_down >= 0)
	{
		how_rise += stack[go_down] - stack[ver_index];
		--go_down;
		--ver_index;
	}
}

int main(void)
{
	int n = 0;
	cin >> n;
	long long int stack[100001];
	stack[0] = 10000000000;

	//ver_index -= 1;
	int tmp_0 = 0;
	int tmp_1 = 0;
	long long int to_stack;
	int ver = 1;


	for (int i = 0; i < n; ++i)
	{
		cin >> to_stack;
		if (to_stack < stack[ver - 1]) {
			stack[ver] = to_stack;
			ver++;

		}
		else if (to_stack > stack[ver - 1]) {

			if (to_stack < stack[ver - 2]) {
				how_rise += to_stack - stack[ver - 1];
				stack[ver - 1] = to_stack;
			}
			else if (to_stack > stack[ver - 2]) {
				ver--;
				tmp_0 = ver;
				tmp_1 = 0;
				for (tmp_1 = tmp_0; tmp_1 > 0; tmp_1--)
				{
					how_rise += stack[tmp_1 - 1] - stack[tmp_1];
					ver--;


					if (stack[tmp_1 - 2] >= to_stack) break;
				}
				if (stack[tmp_1 - 1] < to_stack) {
					how_rise += to_stack - stack[tmp_1 - 1];


					stack[tmp_1 - 1] = to_stack;
					ver++;
				}
				if (stack[tmp_1 - 1] > to_stack) {
					ver++;
					stack[ver] = to_stack;
					ver++;
				}
			}
			else {
				how_rise += to_stack - stack[ver - 1];
				ver--;
			}
		}
	}

	for (int i = ver - 1; i > 1; --i)
	{
		how_rise += stack[i - 1] - stack[i];
	}

	cout << how_rise;
	/*cout << how_rise + "\n";

	CollapseStack(stack, ver);
	cout << how_rise;
	cin >> how_rise;*/

	return 0;
}