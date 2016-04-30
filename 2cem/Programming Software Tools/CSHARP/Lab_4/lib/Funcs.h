
// lib.h

#ifdef LIB_EXPORTS
#define FUNCS_API __declspec(dllexport) 
#else
#define FUNCS_API __declspec(dllimport) 
#endif

namespace MathFuncs
{
    // This class is exported from the MathFuncsDll.dll

        // Returns a + b
		FUNCS_API double Add(double a, double b); 

        // Returns a - b
        FUNCS_API double Subtract(double a, double b); 

        // Returns a * b
        FUNCS_API double Multiply(double a, double b); 

        // Returns a / b
        // Throws const std::invalid_argument& if b is 0
        FUNCS_API double Divide(double a, double b); 
    
}