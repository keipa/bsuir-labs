// TestEvent.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "windows.h"
#include "process.h" 

HANDLE event;

void Test1(void *);
void Test2(void *);
void Test3(void *);

void main()
{
	event = CreateEvent(NULL, TRUE, FALSE, L"FirstStep");
	if (_beginthread(Test1, 1024, NULL) == -1)
		printf("Error begin thread ");
	if (_beginthread(Test2, 1024, NULL) == -1)
		printf("Error begin thread ");
		if (_beginthread(Test3, 1024, NULL) == -1)
			printf("Error begin thread ");
	if (event != NULL) {
		Sleep(1000);
		SetEvent(event);
		Sleep(1000);
		ResetEvent(event);
		CloseHandle(event);
	}
	else {
		printf("Error create event ");
	}

}

void Test1(void *)
{
	DWORD dwWaitResult;
	while (dwWaitResult != WAIT_OBJECT_0) {
		dwWaitResult = WaitForSingleObject(event, 1);
		printf("Test 1 TIMEOUT");
	}
	printf("Event Test 1 ");
	_endthread();
}

void Test2(void *)
{
	DWORD dwWaitResult;
	while (dwWaitResult != WAIT_OBJECT_0) {
		dwWaitResult = WaitForSingleObject(event, 1);
		printf("Test 2 TIMEOUT");
	}
	printf("Event Test 2 ");
	_endthread();
}

void Test3(void *)
{
	DWORD dwWaitResult;
	while (dwWaitResult != WAIT_OBJECT_0) {
		dwWaitResult = WaitForSingleObject(event, 1);
		printf("Test 3 TIMEOUT");
	}
	printf("Event Test 3 ");
	_endthread();
}