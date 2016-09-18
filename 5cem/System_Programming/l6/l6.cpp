#include "stdafx.h"
#include "l6.h"

HINSTANCE hInst;
TCHAR* szTitle = _T("Title");
TCHAR* szText = _T("Scrolling text");
TCHAR* szWindowClass = _T("Lab1");
HWND hButton1, hButton2;

LPWSTR letters[5];
UINT letterX[5];
INT letterY[5];
HANDLE hEvent1;
UINT letterSpeed[5];
HANDLE threads[5];
HWND  listbox1;
TCHAR* first_critical_section_text = _T("first critical section");
TCHAR* second_critical_section_text = _T("second critical section");
TCHAR* first_event_text = _T("first event");
TCHAR* second_event_text = _T("second event");

CRITICAL_SECTION cs;


ATOM				RegisterWindowClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);

int APIENTRY _tWinMain(_In_ HINSTANCE hInstance,
	_In_opt_ HINSTANCE hPrevInstance,
	_In_ LPTSTR    lpCmdLine,
	_In_ int       nCmdShow)
{
	RegisterWindowClass(hInstance);

	if (!InitInstance(hInstance, nCmdShow))
	{
		return FALSE;
	}

	MSG msg;
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return (int)(msg.wParam);
}


ATOM RegisterWindowClass(HINSTANCE hInstance)
{
	WNDCLASSEX wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);

	wcex.style = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc = WndProc;
	wcex.cbClsExtra = 0;
	wcex.cbWndExtra = 0;
	wcex.hInstance = hInstance;
	wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ERROR));
	wcex.hCursor = LoadCursor(hInstance, MAKEINTRESOURCE(IDC_HAND));
	wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
	wcex.lpszMenuName = MAKEINTRESOURCE(IDI_ERROR);
	wcex.lpszClassName = szWindowClass;
	wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_ERROR));

	return RegisterClassEx(&wcex);
}



bool running = TRUE;


DWORD WINAPI ThreadProc(LPVOID param) {

	int idx = (int)param;
	int i = 10;
	while (i-->0) {
		InitializeCriticalSection(&cs);
		EnterCriticalSection(&cs);
		Sleep(100);
		if (idx == 0)
		{
			SendMessage(listbox1, LB_ADDSTRING, NULL, (LPARAM)first_critical_section_text);
		}
		else
		{
			SendMessage(listbox1, LB_ADDSTRING, NULL, (LPARAM)second_critical_section_text);
		}
		LeaveCriticalSection(&cs);
		DeleteCriticalSection(&cs);
	}
	i = 50;

	while (i) {
		WaitForSingleObject(hEvent1, INFINITE);
		Sleep(100);
		if (idx == 0)
		{
			SendMessage(listbox1, LB_ADDSTRING, NULL, (LPARAM)first_event_text);
		}
		else
		{
			SendMessage(listbox1, LB_ADDSTRING, NULL, (LPARAM)second_event_text);
		}
		SetEvent(hEvent1);
	}
	return 0;
}

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
	HWND hWnd;

	hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);


	listbox1 = CreateWindowEx(NULL, L"LISTBOX", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | LBS_EXTENDEDSEL | WS_VSCROLL, 0, 30, 260, 300, hWnd, NULL, hInstance, NULL);
	if (!hWnd)
	{
		return FALSE;
	}

	MoveWindow(hWnd, 100, 40, 300, 400, FALSE);
	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);

	hEvent1 = CreateEvent(NULL, FALSE, TRUE, NULL);
	SetEvent(hEvent1);
	for (int i = 0; i < 2; i++)
		threads[i] = CreateThread(NULL, 2000, &ThreadProc, (LPVOID)i, 0, NULL);

	SetTimer(hWnd, 1, 3, NULL);

	return TRUE;
}



void DoTimer(HWND hWnd) {
	InvalidateRect(hWnd, NULL, TRUE);
}



LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int wmId, wmEvent;
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message)
	{
	case WM_COMMAND:
		wmId = LOWORD(wParam);
		wmEvent = HIWORD(wParam);
		switch (wmId)
		{
		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
		}
		break;
	case WM_TIMER:
		DoTimer(hWnd);
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}
