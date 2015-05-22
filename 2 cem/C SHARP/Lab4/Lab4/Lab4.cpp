#include "stdafx.h"
#include "stdio.h"
#include "Lab4.h"

bool __stdcall OpenSound (const char* _filename)
{
  char cmdbuffer[1000];
  sprintf(cmdbuffer, "open %s alias mydevice", _filename); 
  
  if(mciSendString(cmdbuffer, NULL, 0, NULL) != 0)
    return false;

  return true;
}

bool __cdecl StartSound (void)
{
  if(mciSendString("play mydevice from 0", NULL, 0, NULL) != 0)
    return false;

  return true;
}

bool __cdecl StopSound (void)
{
  if(mciSendString("stop mydevice", NULL, 0, NULL) != 0)
    return false;

  return true;
}

bool __stdcall CloseSound (void)
{
  if(mciSendString("close mydevice", NULL, 0, NULL) != 0)
    return false;

  return true;
}

