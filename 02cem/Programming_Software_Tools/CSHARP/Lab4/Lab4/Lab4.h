#ifndef LAB4H
#define LAB4H

#include <windows.h>
#include <mmsystem.h>

#ifdef LAB4_EXPORTS
#define LAB4_API __declspec(dllexport)
#else
#define LAB4_API __declspec(dllimport)
#endif

extern "C"
{
	LAB4_API bool __stdcall OpenSound (const char* _filename);
	LAB4_API bool __cdecl StartSound (void);
	LAB4_API bool __cdecl StopSound (void);
	LAB4_API bool __stdcall CloseSound (void);
};
#endif