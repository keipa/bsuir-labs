#include <windows.h>
#include "stdafx.h"
#include <stdlib.h>
#include <tchar.h>
#include <string.h>
#include <time.h>

#define ID_BUTTONSTART 1001
#define ID_BUTTONSTOP 1003

bool isOn = false;

HINSTANCE hInst;
HWND hButtonStart, hButtonStop;
HANDLE hThread[3];

typedef struct hrect
{
	HWND hWnd;
	int x, y, len, sleep, delta;
	hrect() {};
	hrect(HWND hWnd, int x, int y, int len, int sleep) : hWnd(hWnd), x(x), y(y), len(len), sleep(sleep) {};
} MYRECT, *PMYRECT;

typedef struct rgb {
	int r, g, b;
	rgb() {};
	rgb(int r, int g, int b) : r(r), g(g), b(b) {};
} MYRGB;

MYRECT r[3];
MYRGB c[3];

LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

void changeXY(LPVOID tParam)
{
	PMYRECT t = (PMYRECT)tParam;
	srand(time(NULL));
	t->delta = rand() % 3 - 1;
	if (t->x + t->delta > 0 && t->x + t->delta + t->len < 301)
		t->x += t->delta;
	t->delta = rand() % 3 - 1;
	if (t->y + t->delta > 0 && t->y + t->delta + t->len < 401)
		t->y += t->delta;
	return;
}

DWORD WINAPI funThread(LPVOID tParam)
{
	PMYRECT t = (PMYRECT)tParam;
	while (true)
	{
		changeXY(t);
		InvalidateRect(t->hWnd, NULL, TRUE);
		Sleep(t->sleep);
	}
	return 0;
}

int WINAPI WinMain(HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nCmdShow)
{
	WNDCLASSEX wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);
	wcex.style = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc = WndProc;
	wcex.cbClsExtra = 0;
	wcex.cbWndExtra = 0;
	wcex.hInstance = hInstance;
	wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_APPLICATION));
	wcex.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
	wcex.lpszMenuName = NULL;
	wcex.lpszClassName = _T("Forth Lab Class");
	wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_APPLICATION));

	RegisterClassEx(&wcex);
	hInst = hInstance;
	HWND hWnd = CreateWindow(_T("Forth Lab Class"), _T("Forth Lab Title"), WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT,
		300, 400, NULL, NULL, hInstance, NULL);

	r[0] = hrect(hWnd, 0, 0, 25, 50);
	r[1] = hrect(hWnd, 120, 0, 35, 100);
	r[2] = hrect(hWnd, 230, 0, 45, 200);

	c[0] = rgb(255, 0, 0);
	c[1] = rgb(0, 255, 0);
	c[2] = rgb(0, 0, 255);

	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);

	for (int i = 0; i < 3; i++)
	{
		hThread[i] = CreateThread(NULL, 0, funThread, &r[i], 0, NULL);
		SuspendThread(hThread[i]);
	}


	MSG msg;
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return (int)msg.wParam;
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message)
	{
	case WM_CREATE:
		hButtonStart = CreateWindow(_T("BUTTON"), _T("Start"), WS_CHILD | WS_VISIBLE | BS_DEFPUSHBUTTON,
			10, 330, 70, 20, hWnd, (HMENU)ID_BUTTONSTART, hInst, NULL);
		hButtonStop = CreateWindow(_T("BUTTON"), _T("Stop"), WS_CHILD | WS_VISIBLE | BS_DEFPUSHBUTTON,
			210, 330, 70, 20, hWnd, (HMENU)ID_BUTTONSTOP, hInst, NULL);
		break;

	case WM_PAINT:
		hdc = BeginPaint(hWnd, &ps);
		for (int i = 0; i < 3; i++)
		{
			SelectObject(hdc, CreateSolidBrush(RGB(c[i].r, c[i].g, c[i].b)));
			Rectangle(hdc, r[i].x, r[i].y, r[i].x + r[i].len, r[i].y + r[i].len);
		}
		EndPaint(hWnd, &ps);
		break;

	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case ID_BUTTONSTART:
			if (isOn)
				break;
			for (int i = 0; i < 3; i++)
			{
				ResumeThread(hThread[i]);
			}
			isOn = true;
			break;

		case ID_BUTTONSTOP:
			if (!isOn)
				break;
			for (int i = 0; i < 3; i++)
			{
				SuspendThread(hThread[i]);
			}
			isOn = false;
			break;
		}
		break;

	case WM_DESTROY:
		PostQuitMessage(0);
		break;

	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
		break;
	}

	return 0;
}