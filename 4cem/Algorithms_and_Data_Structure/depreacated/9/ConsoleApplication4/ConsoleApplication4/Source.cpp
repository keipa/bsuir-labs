#include <iostream>
using namespace std;

int main()
{
    int N;
    int last_element = 1;
    long long int A_i;
    int b, j;
    long long int answer = 0;

    long long int A[100001];
    A[0] = 10000000000;
    cin >> N;

    for (int i = 0; i < N; ++i)
    {
        cin >> A_i;
        if (A_i < A[last_element - 1]) {
            A[last_element] = A_i;
            last_element++;

        } else if (A_i > A[last_element - 1]) {

            if (A_i < A[last_element - 2]) {
                answer += A_i - A[last_element - 1];
                A[last_element - 1] = A_i;
            } else if (A_i > A[last_element - 2]) {
                last_element--;
                j = last_element;
                b = 0;
                for (b = j; b > 0; b--)
                {
                    answer += A[b - 1] - A[b];
                    last_element--;
                    if (A[b - 2] >= A_i) break;
                }
                if (A[b - 1] < A_i) {
                    answer += A_i - A[b - 1];
                    A[b - 1] = A_i;
                    last_element++;
                }
                if (A[b - 1] > A_i) {
                    last_element++;
                    A[last_element] = A_i;
                    last_element++;
                }
            } else {
                answer += A_i - A[last_element - 1];
                last_element--;
            }
        }
    }

    for (int i = last_element - 1; i > 1; --i)
    {
        answer += A[i-1] - A[i];
    }

    cout << answer;

    return 0;
}