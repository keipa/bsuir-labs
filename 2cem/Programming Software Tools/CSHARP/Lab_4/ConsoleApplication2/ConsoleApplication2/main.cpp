#include "main.h"


#include <stdexcept>



extern "C"
{


    using namespace std;


    __declspec(dllexport) double Add(double a, double b)
    {
        return a + b;
    }

   __declspec(dllexport) double Subtract(double a, double b)
    {
        return a - b;
    }

   __declspec(dllexport) double Multiply(double a, double b)
    {
        return a * b;
    }

   __declspec(dllexport) double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw invalid_argument("b cannot be zero!");
        }

        return a / b;
    }
}








