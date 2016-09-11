
#include "stdafx.h"
#include "odib.h"
#include "resource.h"

HINSTANCE hInst;
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);
COLORREF colorText = RGB(0, 0, 255);
PAINTSTRUCT ps;
RECT rect;
static POINTS ptsBegin;

int APIENTRY _tWinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow) {
	MSG msg;
	HACCEL hAccelTable;
	TCHAR s[BUFFSIZE];
	MyRegisterClass(hInstance);

	if (!InitInstance (hInstance, nCmdShow)) {
		return FALSE;
	}
	hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(ID_ACCEL));


	
	while (GetMessage(&msg, NULL, 0, 0)) {
		if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg)) {
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	return (int) msg.wParam;
}
int heigh = 400;



ATOM MyRegisterClass(HINSTANCE hInstance) {
	WNDCLASSEX wcex;
	wcex.cbSize = sizeof(WNDCLASSEX); 
	wcex.style			= CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc	= (WNDPROC)WndProc;
	wcex.cbClsExtra		= 0;
	wcex.cbWndExtra		= 0;
	wcex.hInstance		= hInstance;
	wcex.hIcon			= LoadIcon(hInstance, (LPCTSTR)IDI_ODIB);
	wcex.hCursor		= LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground	= (HBRUSH)(COLOR_WINDOW+1);
	wcex.lpszMenuName	= (LPCTSTR)ID_MENU;
	wcex.lpszClassName	= sAppName;
	wcex.hIconSm		= LoadIcon(wcex.hInstance, (LPCTSTR)IDI_SMALL);

	return RegisterClassEx(&wcex);
}


BOOL InitInstance(HINSTANCE hInstance, int nCmdShow) {
   HWND hWnd;
	TCHAR s[BUFFSIZE];
   hInst = hInstance;

	hWnd = CreateWindow(
		sAppName,
		sAppName,
		WS_OVERLAPPEDWINDOW,
		GetSystemMetrics (SM_CXSCREEN) / 3,
		GetSystemMetrics (SM_CYSCREEN) / 3,
		GetSystemMetrics (SM_CXSCREEN) / 3,
		GetSystemMetrics (SM_CYSCREEN) / 4,
		HWND_DESKTOP,
		NULL,
		hInstance,
		NULL);
   if (!hWnd) {
		_stprintf(s, _T("! Main window creation failed (InitInstance)"));
		myWriteToLog(s);
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}



LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) {
	PAINTSTRUCT ps;
	HDC hdc;
	static HINSTANCE hInst;
	static RECT btnrect;
	
	static DRAWITEMSTRUCT* pdis;
	
	static long cxClient, cyClient;
	TCHAR s[BUFFSIZE];
	int iResult;
	SetWindowPos(hWnd, NULL, 0, 0, 200, 200, SWP_NOMOVE | SWP_NOSIZE);
	switch (message) {
		case WM_DRAWITEM:
			
			
			pdis = (DRAWITEMSTRUCT*) lParam;
			
			switch(pdis->CtlID) {
				case IDC_LEVELUPBUTTON:
					
				case IDC_LEVELDNBUTTON:
					iResult = myManageOwnerDrawIconButton(pdis, hInst);
					if (RET_OK != iResult) {
						_stprintf(s, _T("! %d from myManageOwnerDrawIconButton (WM_DRAWITEM)"), iResult);
						myWriteToLog(s);
						return(FALSE);
					}
					break;
				
				default:
					break;
			}
			return(TRUE);
		case WM_CREATE:
			hInst = ((LPCREATESTRUCT) lParam)->hInstance;
			
			
			
			
			
			hBackgroundStatic = CreateWindow(_T("static"), NULL,
				WS_CHILD | WS_VISIBLE,
				0,0,0,0,
				hWnd,
				(HMENU) IDC_BACKGROUNDSTATIC,
				hInst,
				NULL);
			if (!hBackgroundStatic) {
				_stprintf(s, _T("! hBackgroundStatic NULL"));
				myWriteToLog(s);
			}
			
			
			hLevelUpButton = CreateWindow(_T("button"), NULL,
				WS_CHILD | WS_VISIBLE | BS_OWNERDRAW,
				0,0,0,0,
				hWnd,
				(HMENU) IDC_LEVELUPBUTTON,
				hInst,
				NULL);
			if (NULL == hLevelUpButton) {
				_stprintf(s, _T("! hLevelUpButton NULL"));
				myWriteToLog(s);
			}
			
			hLevelDnButton = CreateWindow(_T("button"), NULL,
				WS_CHILD | WS_VISIBLE | BS_OWNERDRAW,
				0,0,0,0,
				hWnd,
				(HMENU) IDC_LEVELDNBUTTON,
				hInst,
				NULL);
			if (NULL == hLevelDnButton) {
				_stprintf(s, _T("! hLevelDnButton NULL"));
				myWriteToLog(s);
			}
			SetWindowPos(hWnd, NULL, 0, 0, 600, 400, SWP_NOMOVE);
			break;
		case WM_SIZE:
			cxClient = LOWORD(lParam);
			cyClient = HIWORD(lParam);
			
			
			if (wParam != SIZE_MINIMIZED) {
				MoveWindow(hLevelUpButton,
					(cxClient - 2 * ICON_WIDTH - MARGIN) / 2,  
					0,  
					ICON_WIDTH,  
					ICON_HEIGHT,  
					TRUE);  
				
				MoveWindow(hLevelDnButton,
					(cxClient + MARGIN) / 2,  
					0,  
					ICON_WIDTH,  
					ICON_HEIGHT,  
					TRUE);  
				
				MoveWindow(hDisplayEdit,
					0,  
					ICON_HEIGHT + MARGIN,  
					cxClient,  
					cyClient - ICON_HEIGHT - MARGIN,  
					TRUE);  
				
				MoveWindow(hBackgroundStatic,
					0,  
					0,  
					cxClient,  
					cyClient,  
					TRUE);  
			}
			break;
		case WM_COMMAND:
			switch(LOWORD(wParam)) {
				case IDC_LEVELUPBUTTON:
					if (BN_CLICKED == HIWORD(wParam))
						SendMessage(hWnd, WM_COMMAND, (WPARAM) IDM_LEVELUP, 0);
					break;
				case IDC_LEVELDNBUTTON:
					if (BN_CLICKED == HIWORD(wParam))
						SendMessage(hWnd, WM_COMMAND, (WPARAM) IDM_LEVELDN, 0);
					break;
				case IDM_LEVELUP:
					ptsBegin = MAKEPOINTS(lParam);
					hdc = GetDC(hWnd);
					ptsBegin.x += 75;
					ptsBegin.y += 50;
					MoveToEx(hdc, ptsBegin.x - 15, ptsBegin.y, (LPPOINT)NULL);
					LineTo(hdc, ptsBegin.x + 20, ptsBegin.y);
					LineTo(hdc, ptsBegin.x + 20 + 30, ptsBegin.y + 10);
					LineTo(hdc, ptsBegin.x + 20 + 30 + 25, ptsBegin.y);
					LineTo(hdc, ptsBegin.x + 20 + 30 + 25 + 5, ptsBegin.y + 5);
					LineTo(hdc, ptsBegin.x + 20 + 30 + 25, ptsBegin.y + 5);
					LineTo(hdc, ptsBegin.x + 20 + 30 + 25 - 3, ptsBegin.y + 7);
					LineTo(hdc, ptsBegin.x + 20 + 30 + 25 - 3 + 5, ptsBegin.y + 7 + 2);
					LineTo(hdc, ptsBegin.x + 107 + 2, ptsBegin.y + 7 + 12 - 5 - 10);
					LineTo(hdc, ptsBegin.x + 107 + 2 + 3, ptsBegin.y + 7 + 12 - 5 - 10 + 2);
					LineTo(hdc, ptsBegin.x + 107 + 2 + 3 + 3, ptsBegin.y + 7 + 12 - 5 + 2 + 10);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 10, ptsBegin.y + 7 + 12 - 5 + 2 + 6);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 10 - 5, ptsBegin.y + 7 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 10 - 5 - 30, ptsBegin.y + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 10 - 5 - 20 - 30, ptsBegin.y + 5 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 10 - 10 - 20 - 30, ptsBegin.y + 15 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 107 + 2 - 40 - 10, ptsBegin.y + 45 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 109 - 50, ptsBegin.y + 45 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 109 - 90, ptsBegin.y + 5 + 7 + 60 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 109 - 90, ptsBegin.y + 5 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x - 5, ptsBegin.y + 5 + 7 + 30 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x + 5, ptsBegin.y + 5 + 7 + 10 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x, ptsBegin.y + 10 + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x, ptsBegin.y + 12 - 5 + 2 + 6 + 3);
					LineTo(hdc, ptsBegin.x - 15, ptsBegin.y - 11 + 2 + 6 + 3);
					MoveToEx(hdc, ptsBegin.x + 200, ptsBegin.y + 20, (LPPOINT)NULL);
					LineTo(hdc, ptsBegin.x + 210, ptsBegin.y + 20);
					LineTo(hdc, ptsBegin.x + 250, ptsBegin.y);
					LineTo(hdc, ptsBegin.x + 290, ptsBegin.y + 10);
					LineTo(hdc, ptsBegin.x + 400, ptsBegin.y + 5);
					LineTo(hdc, ptsBegin.x + 400 - 10, ptsBegin.y + 5 + 5);
					LineTo(hdc, ptsBegin.x + 400 - 10, ptsBegin.y + 5 + 5 + 30);
					LineTo(hdc, ptsBegin.x + 400 - 10 - 5, ptsBegin.y + 5 + 5 + 30 - 7);
					LineTo(hdc, ptsBegin.x + 400 - 10 - 5 - 5, ptsBegin.y + 5 + 5 + 30 - 5);
					LineTo(hdc, ptsBegin.x + 400 - 10 - 5 - 5 + 2, ptsBegin.y + 5 + 5 + 30);
					LineTo(hdc, ptsBegin.x + 400 - 10 - 5 - 5 + 2, ptsBegin.y + 5 + 5 + 30 + 20);
					LineTo(hdc, ptsBegin.x + 400 - 10 - 5 - 5 + 2 - 15, ptsBegin.y + 5 + 5 + 30 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 10 + 2 - 15, ptsBegin.y + 5 + 5 + 5 + 30 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 10 + 2 - 25, ptsBegin.y + 5 + 5 + 30 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 10 + 2 - 30, ptsBegin.y + 30 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 10 + 2 - 40, ptsBegin.y + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 10 + 2 - 40, ptsBegin.y + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 40, ptsBegin.y - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 40 - 10 + 12 - 40, ptsBegin.y + 10 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 40, ptsBegin.y + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 55, ptsBegin.y + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 75, ptsBegin.y + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20, ptsBegin.y - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20 - 10, ptsBegin.y - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20 - 10, ptsBegin.y - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20 - 10 - 20, ptsBegin.y - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20 - 10 - 20 - 10, ptsBegin.y - 10 - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					LineTo(hdc, ptsBegin.x + 400 - 145 + 2 - 20 - 10 - 20 - 10 + 2, ptsBegin.y - 20 - 10 - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
					MoveToEx(hdc, ptsBegin.x + 210, ptsBegin.y + 60, (LPPOINT)NULL);
					LineTo(hdc, ptsBegin.x + 230, ptsBegin.y + 75);
					LineTo(hdc, ptsBegin.x + 250 + 5, ptsBegin.y + 81);
					LineTo(hdc, ptsBegin.x + 250 + 15, ptsBegin.y + 110);
					LineTo(hdc, ptsBegin.x + 250 + 15 + 10, ptsBegin.y + 112);
					LineTo(hdc, ptsBegin.x + 250 + 5, ptsBegin.y + 160);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30, ptsBegin.y + 180);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30, ptsBegin.y + 130);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 10, ptsBegin.y + 130 - 10);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 15, ptsBegin.y + 130 - 10);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 15 - 15, ptsBegin.y + 130 - 15);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 40, ptsBegin.y + 130 - 25);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 40, ptsBegin.y + 130 - 25 - 25);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 40 + 15, ptsBegin.y + 130 - 25 - 25 - 20);
					LineTo(hdc, ptsBegin.x + 250 + 5 - 30 - 40 + 25, ptsBegin.y + 130 - 25 - 25 - 20);
					ptsBegin.x += 75;
					ptsBegin.y += 115;
					MoveToEx(hdc, ptsBegin.x - 15, ptsBegin.y, (LPPOINT)NULL);
					LineTo(hdc, ptsBegin.x + 3, ptsBegin.y);
					LineTo(hdc, ptsBegin.x + +20, ptsBegin.y + 20);
					LineTo(hdc, ptsBegin.x + 20 + 10, ptsBegin.y + 20);
					LineTo(hdc, ptsBegin.x + 30 + 10, ptsBegin.y + 20 + 10);
					LineTo(hdc, ptsBegin.x + 20, ptsBegin.y + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + 20 - 5 - 5, ptsBegin.y + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + 20 - 5 - 5 - 10, ptsBegin.y + 5 + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + 20 - 5 - 5 - 10, ptsBegin.y + 5 + 15 + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + 20 - 5 - 5 - 10 + 5, ptsBegin.y + 5 + 5 + 15 + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + 20 - 5 - 5 - 10 + 5, ptsBegin.y + 15 + 5 + 15 + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + -5 - 5 - 10 + 5, ptsBegin.y + 15 + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + -5 - 5 - 10 + 5 - 3, ptsBegin.y + 20 + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + -5 - 5 - 10 + 5 - 3 - 2, ptsBegin.y + 20 + 10 + 20);
					LineTo(hdc, ptsBegin.x + -5 - 5 - 10 + 5 - 3 - 2 - 20, ptsBegin.y + 10 - 10 + 10 + 20);
					LineTo(hdc, ptsBegin.x - 15, ptsBegin.y);
					MoveToEx(hdc, ptsBegin.x - 15 + 350, ptsBegin.y + 50, (LPPOINT)NULL);
					LineTo(hdc, ptsBegin.x - 15 + 350 - 10, ptsBegin.y + 50 + 20);
					LineTo(hdc, ptsBegin.x - 15 + 350 - 10 - 10, ptsBegin.y + 50 + 10);
					LineTo(hdc, ptsBegin.x - 15 + 350 - 10 - 10 - 20, ptsBegin.y + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 350 - 10 - 10 - 20 - 15, ptsBegin.y - 10 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 350 - 10 - 10 - 20 - 20, ptsBegin.y - 25 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 360 - 10 - 10 - 20 - 20, ptsBegin.y - 30 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 360 + 15 - 10 - 10 - 20 - 20, ptsBegin.y - 30 - 4 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 10 + 360 + 15 - 10 - 10 - 20 - 20, ptsBegin.y - 30 - 4 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 10 + 360 + 15 - 10 - 10 - 20 - 20 + 5, ptsBegin.y + 5 - 30 - 4 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 10 + 360 + 15 - 10 - 10 - 20 - 20 + 5, ptsBegin.y - 10 + 5 - 30 - 4 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 10 + 360 + 15 - 20 + 2 - 20 - 20 + 5, ptsBegin.y + 7 - 10 + 5 - 30 - 4 + 50 + 10 + 5);
					LineTo(hdc, ptsBegin.x - 15 + 10 + 360 + 15 - 20 + 2 - 40 + 26, ptsBegin.y + 17 + 7 - 10 + 5 - 30 - 4 + 50 + 10 + 5);
					EndPaint(hWnd, &ps);
					ClipCursor(NULL);
					break;
						SendMessage(hDisplayEdit, WM_SETTEXT, 0, (LPARAM) _T("Up button pressed"));
					break;
				case IDM_LEVELDN:

				    SetWindowPos(hWnd, NULL, 0, 0, 600, ++heigh, SWP_NOMOVE);
					break;
						SendMessage(hDisplayEdit, WM_SETTEXT, 0, (LPARAM) _T("Down button pressed"));
					break;
				case IDM_FILEQUIT:
					SendMessage(hWnd, WM_CLOSE, 0, 0);
					break;
				case IDM_HELPABOUT:
					MessageBox(hWnd, (LPCTSTR) TEXT_HELP_ABOUT, (LPCTSTR) STR_ABOUT, MB_OK | MB_APPLMODAL);
					break;
				default:
					return DefWindowProc(hWnd, message, wParam, lParam);
			}
			break;
		case WM_PAINT:
			hdc = BeginPaint(hWnd, &ps);
			EndPaint(hWnd, &ps);
			break;
		
		case WM_CTLCOLORSTATIC:
			
			
			switch(GetDlgCtrlID((HWND) lParam)) {
				case IDC_DISPLAYEDIT:
					
					SetBkColor((HDC) wParam, RGB(255,255,255));
					SetTextColor((HDC) wParam, RGB(32,32,128));
					return (LRESULT) GetStockObject(WHITE_BRUSH);
				
				default:
					break;
			}
			break;
		case WM_CLOSE:
			DestroyWindow(hLevelUpButton);
			DestroyWindow(hLevelDnButton);
			DestroyWindow(hDisplayEdit);
			
			
			DestroyWindow(hWnd);
			break;
		case WM_DESTROY:
			PostQuitMessage(0);
			break;
		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

