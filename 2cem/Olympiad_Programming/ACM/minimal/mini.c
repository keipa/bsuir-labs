

#include <stdlib.h>


int main()
{
    char ch[100], temp[100];
    int arr[100], count = 0;
    cin.getline(ch, 100);
    for (int i = 0, j = 0; i <= strlen(ch); i++){
        if (ch[i] >= '0' && ch[i] <= '9'){ temp[j] = ch[i]; j++; }
        else {
            temp[j] = '\0';
            j = 0;
            arr[count++] = atoi(temp);
        }
    }
    for (int i = 0; i < count; i++)
        cout << arr[i] << endl;
    return 0;
}
