// lib.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "Funcs.h"
#include <stdexcept>

using namespace std;

namespace MathFuncs
{
    double Add(double a, double b)
    {
        return a + b;
    }

    double Subtract(double a, double b)
    {
        return a - b;
    }

    double Multiply(double a, double b)
    {
        return a * b;
    }

    double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw invalid_argument("b cannot be zero!");
        }

        return a / b;
    }
}




