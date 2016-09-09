


#include "stdafx.h"
#include "l2.h"

#define MAX_LOADSTRING 100


HINSTANCE hInst;
WCHAR szTitle[MAX_LOADSTRING];
WCHAR szWindowClass[MAX_LOADSTRING];
HWND textbox, listbox1, listbox2;
wchar_t text[100];
int itemarea[10];


ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
	_In_opt_ HINSTANCE hPrevInstance,
	_In_ LPWSTR    lpCmdLine,
	_In_ int       nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);




	LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
	LoadStringW(hInstance, IDC_L2, szWindowClass, MAX_LOADSTRING);
	MyRegisterClass(hInstance);


	if (!InitInstance(hInstance, nCmdShow))
	{
		return FALSE;
	}

	HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_L2));

	MSG msg;


	while (GetMessage(&msg, nullptr, 0, 0))
	{
		if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	return (int)msg.wParam;
}








ATOM MyRegisterClass(HINSTANCE hInstance)
{
	WNDCLASSEXW wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);

	wcex.style = CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc = WndProc;
	wcex.cbClsExtra = 0;
	wcex.cbWndExtra = 0;
	wcex.hInstance = hInstance;
	wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_L2));
	wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
	wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
	wcex.lpszMenuName = MAKEINTRESOURCEW(IDC_L2);
	wcex.lpszClassName = szWindowClass;
	wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

	return RegisterClassExW(&wcex);
}











BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
	hInst = hInstance;

	HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

	if (!hWnd)
	{
		return FALSE;
	}

	textbox = CreateWindowEx(NULL, L"EDIT", L"", WS_VISIBLE | WS_BORDER | WS_CHILD, 0, 0, 300, 20, hWnd, NULL, hInstance, NULL);
	listbox1 = CreateWindowEx(NULL, L"LISTBOX", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | LBS_EXTENDEDSEL, 0, 30, 300, 300, hWnd, NULL, hInstance, NULL);
	listbox2 = CreateWindowEx(NULL, L"LISTBOX", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | LBS_EXTENDEDSEL, 300, 30, 300, 300, hWnd, NULL, hInstance, NULL);
	CreateWindowEx(NULL, L"BUTTON", L"ADD", WS_VISIBLE | WS_BORDER | WS_CHILD, 300, 0, 40, 20, hWnd, (HMENU)150, hInstance, NULL);
	CreateWindowEx(NULL, L"BUTTON", L"TRT", WS_VISIBLE | WS_BORDER | WS_CHILD, 340, 0, 40, 20, hWnd, (HMENU)151, hInstance, NULL);
	CreateWindowEx(NULL, L"BUTTON", L"CLR", WS_VISIBLE | WS_BORDER | WS_CHILD, 380, 0, 40, 20, hWnd, (HMENU)152, hInstance, NULL);
	CreateWindowEx(NULL, L"BUTTON", L"DEL", WS_VISIBLE | WS_BORDER | WS_CHILD, 420, 0, 40, 20, hWnd, (HMENU)153, hInstance, NULL);
	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);

	return TRUE;
}

bool check(HWND listbox, wchar_t * text) {
	int count = SendMessage(listbox, LB_GETCOUNT, NULL, NULL);
	for (int i = 0; i < count; i++) {
		wchar_t old[100];
		SendMessage(listbox, LB_GETTEXT, i, (LPARAM)old);
		if (wcscmp(old, text) == 0)
			return false;
	}
	return true;
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_COMMAND:
	{
		int wmId = LOWORD(wParam);

		switch (wmId)
		{
		case 150:
			GetWindowText(textbox, text, 100);
			if (check(listbox1, text))
				SendMessage(listbox1, LB_ADDSTRING, NULL, (LPARAM)text);
			break;
		case 151:
			if (int j = SendMessage(listbox1, LB_GETSELITEMS, sizeof(itemarea), (LPARAM)itemarea)) {
				SendMessage(listbox1, LB_GETTEXT, itemarea[0], (LPARAM)text);
				if (check(listbox2, text))
					SendMessage(listbox2, LB_ADDSTRING, NULL, (LPARAM)text);
			}
			break;
		case 152:
			SendMessage(listbox2, LB_RESETCONTENT, NULL, NULL);
			SendMessage(listbox1, LB_RESETCONTENT, NULL,NULL);
			break;
		case 153:
			if (int j = SendMessage(listbox1, LB_GETSELITEMS, sizeof(itemarea), (LPARAM)itemarea)) {
				SendMessage(listbox1, LB_DELETESTRING, itemarea[0], NULL);
			}
			if (int j = SendMessage(listbox2, LB_GETSELITEMS, sizeof(itemarea), (LPARAM)itemarea)) {
				SendMessage(listbox2, LB_DELETESTRING, itemarea[0], NULL);
			}
			break;
		case IDM_ABOUT:
			DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
			break;
		case IDM_EXIT:
			DestroyWindow(hWnd);
			break;
		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
		}
	}
	break;
	case WM_PAINT:
	{
		PAINTSTRUCT ps;
		HDC hdc = BeginPaint(hWnd, &ps);

		EndPaint(hWnd, &ps);
	}
	break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}


INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	UNREFERENCED_PARAMETER(lParam);
	switch (message)
	{
	case WM_INITDIALOG:
		return (INT_PTR)TRUE;

	case WM_COMMAND:
		if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
		{
			EndDialog(hDlg, LOWORD(wParam));
			return (INT_PTR)TRUE;
		}
		break;
	}
	return (INT_PTR)FALSE;
}
