#include <stdio.h>

//#pragma comment(lib,"kernel32.lib")


extern "C"
{
	__declspec(dllexport) void DisplayHelloFromDLL()
	{
		printf("Hello from DLL !\n");
	}
}

/*Please note that __declspec(dllexport) is an obligatory prefix which makes DLL functions available from an external application.

extern “C” (with brackets) is also very important, it shows that all code within brackets is available from “outside”. Although code will compile even without this statement, during runtime, you’ll get a very unpleasant error. So, do not forget to include it.*/