#include <iostream>
#include <cstdio>
using namespace std;
int main(int argc, char const *argv[])
{
unsigned long long a;
unsigned long long b;
unsigned long long c;
int n;
int k;
scanf("%d",&n);
bool mas[n];
for (int i = 0;i < n;i++) {
cin >> a;
cin >> b;
cin >> c;

if ((a * b == c)){
mas[i]=true;
}
else{
mas[i]=false;
}
}
for (int i = 0;i < n;i++){
    if(mas[i])cout << "YES\n"; else cout << "NO\n";
}
}
