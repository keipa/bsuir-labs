#include<stdio.h>

extern "C" {
  __declspec(dllexport) int Add(double a, double b)
  {
    return a + b;
  }
}