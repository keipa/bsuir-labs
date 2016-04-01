#include <iostream>
#include <cmath>
double func(double x)
{
    return 38.4621* pow(x, 3) - 364.594*pow(x, 2) - 914.196 * x - 1;
}
double find(double infinum, double supremum, double epsilon)
{
    while (fabs(supremum - infinum) > epsilon)
    {
        infinum = supremum - (supremum - infinum) * func(supremum) / (func(supremum) - func(infinum));
        supremum = infinum - (infinum - supremum) * func(infinum) / (func(infinum) - func(supremum));
        k++
    }
    return supremum;
}
int main()
{
        double a = -10, b = 10, e = 0.0001;
        int k=0;
        float x = 0
        int f[4]
        f[0] = 38.4621* pow(x, 3) - 364.594*pow(x, 2) - 914.196 * x - 1
        f[1] = 3*x**2 + 2*38.4621*x + 364.594
        for i in range(2, n):
        f[i] = -prem(f[i - 2], f[i - 1])
        Na = 0
        Nb = 0
        for (int i = 0; i<4; i++){
        polim = f[i]*f[i + 1]
        if (subs(x, left) < 0) a_level += 1;
        if (subs(x, right) < 0) b_level += 1;
        }
        std::cout << b_level - a_level<< std::endl;
        std::cout << x<< std::endl;
        x=(a+b)/2;
        while(fabs(b-a)>e){
        if(func(a)*func(x)<=0) b=x;
        else a=x;
        x=(a+b)/2;
        k++;
        }
        std::cout << x<< std::endl;
        std::cout << k << std::endl;
        k = 0
        std::cout << find(a, b, e) << std::endl;
        std::cout << k << std::endl;
        return 0;
}
