
#include <stdio.h>
// a sample exported function


extern "C"
{
	__declspec(dllexport) void DisplayHelloFromDLL()
	{
		printf("Hello from DLL !\n");
	}
}
