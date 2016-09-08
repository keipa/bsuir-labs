#include <windows.h> // заголовочный файл, содержащий функции API
#include <stdlib.h>
#include <string.h>
#include <tchar.h>
#include <math.h>

TCHAR mainMessage[] = "I can set text in the center of the window... and yes, it's blue";

LRESULT CALLBACK WndProc(HWND hwnd, UINT iMsg, WPARAM wParam, LPARAM lParam){
	HDC hDC; // создаЄм дескриптор ориентации текста на экране
	PAINTSTRUCT ps; // структура, сод-ща€ информацию о клиентской области (размеры, цвет и тп)
	RECT rect; // стр-ра, определ€юща€ размер клиентской области
	COLORREF colorText = RGB(0, 0, 255); // задаЄм цвет текста




//	HDC hdc;                       // handle to device context
	RECT rcClient;                 // client area rectangle
	POINT ptClientUL;              // client upper left corner
	POINT ptClientLR;              // client lower right corner
	static POINTS ptsBegin;        // beginning point
	static POINTS ptsEnd;          // new endpoint
	static POINTS ptsPrevEnd;      // previous endpoint
	static BOOL fPrevLine = FALSE; // previous line flag
	TCHAR greeting[] = _T("Hello, World!");
//	PAINTSTRUCT ps;
	//RECT rect;

	hDC = GetDC(hwnd);
	int iter = 400;
	int   k, mx, my;
	float t, x, y ,p, r;
	
	mx = 600;
	my = 1000;
	x = 1.0;
	y = 0.0;
	r = 0.1*my;
	for (k = 1; k < iter; k++){
		p = (rand() % 100) / (100 * 1.0);
		t = x;
		if (p <= 0.85) {
			x = 0.84*x + 0.045*y;
			y = 0.045*t + 0.86*y + 1.6;

			}
		else
			if (p <= 0.9199)
			{
				x = 0.25*x - 0.26*y;
				y = 0.23*t + 0.25*y + 1.6;
			}
			else
				if (p <= 0.999)
				{
					x = -0.135*x + 0.28*y;
					y = 0.26*t + 0.245*y + 0.44;
				}
				else
				{
					x = 0;
					y = 0.16*y;
				}
				SetPixel(hDC, mx + r*x, my - r*y+35, RGB(0, 255, 0));

		

	}


	SetPixel(hDC, 10, 100, RGB(0, 0, 255));






	switch (iMsg){
	case WM_PAINT: // если нужно нарисовать, то:
		hDC = BeginPaint(hwnd, &ps); // инициализируем контекст устройства
		GetClientRect(hwnd, &rect); // получаем ширину и высоту области дл€ рисовани€
		SetTextColor(hDC, colorText); // устанавливаем цвет контекстного устройства
		DrawText(hDC, mainMessage, -1, &rect, DT_SINGLELINE | 400 | DT_VCENTER); // рисуем текст
		

		EndPaint(hwnd, &ps); // заканчиваем рисовать
		break;
	


	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case BN_CLICKED:
			hDC = BeginPaint(hwnd, &ps);
	
			InvalidateRect(hwnd, NULL, TRUE);
			UpdateWindow(hwnd);
			MessageBox(NULL, "04NlllEHO", "LOL", MB_OK);

			EndPaint(hwnd, &ps); // заканчиваем рисовать

		}
	case WM_RBUTTONUP:

		GetClientRect(hwnd, &rcClient);
		ptClientUL.x = rcClient.left;
		ptClientUL.y = rcClient.top;

		ptClientLR.x = rcClient.right + 1;
		ptClientLR.y = rcClient.bottom + 1;
		ClientToScreen(hwnd, &ptClientUL);
		ClientToScreen(hwnd, &ptClientLR);


		SetRect(&rcClient, ptClientUL.x, ptClientUL.y,
			ptClientLR.x, ptClientLR.y);
		ClipCursor(&rcClient);

		hDC = GetDC(hwnd);
		ptsBegin = MAKEPOINTS(lParam);
		//north america
		MoveToEx(hDC, ptsBegin.x - 15, ptsBegin.y, (LPPOINT)NULL);
		LineTo(hDC, ptsBegin.x + 20, ptsBegin.y );
		LineTo(hDC, ptsBegin.x + 20 + 30, ptsBegin.y + 10);
		LineTo(hDC, ptsBegin.x + 20 + 30 + 25 , ptsBegin.y );
		LineTo(hDC, ptsBegin.x + 20 + 30 + 25 + 5, ptsBegin.y + 5);
		LineTo(hDC, ptsBegin.x + 20 + 30 + 25, ptsBegin.y + 5);
		LineTo(hDC, ptsBegin.x + 20 + 30 + 25 -3, ptsBegin.y + 7);
		LineTo(hDC, ptsBegin.x + 20 + 30 + 25 - 3 +5 , ptsBegin.y + 7 +2);
		LineTo(hDC, ptsBegin.x + 107 + 2, ptsBegin.y  + 7 + 12 - 5 -10);
		LineTo(hDC, ptsBegin.x + 107 + 2 +3 , ptsBegin.y + 7 + 12 - 5 - 10 + 2);
		LineTo(hDC, ptsBegin.x + 107 + 2 + 3 +3, ptsBegin.y + 7 + 12 - 5 + 2 +10);
		LineTo(hDC, ptsBegin.x + 107 + 2  -  10, ptsBegin.y + 7 + 12 - 5 + 2 + 6);
		LineTo(hDC, ptsBegin.x + 107 + 2 - 10 -5, ptsBegin.y + 7 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 107 + 2 - 10 - 5 - 30, ptsBegin.y + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 107 + 2 - 10 - 5 -20 - 30, ptsBegin.y +5 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 107 + 2 - 10 - 10 - 20 - 30, ptsBegin.y + 15 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 107 + 2 -40 - 10, ptsBegin.y + 45 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 109 - 50, ptsBegin.y + 45 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 109 - 90, ptsBegin.y + 5 + 7 + 60 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x + 109 - 90, ptsBegin.y + 5 + 7 + 50 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x  - 5, ptsBegin.y + 5 + 7 +30 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x +5, ptsBegin.y + 5 + 7 + 10 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x , ptsBegin.y   + 10 + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x, ptsBegin.y  + 12 - 5 + 2 + 6 + 3);
		LineTo(hDC, ptsBegin.x - 15, ptsBegin.y  -11 + 2 + 6 + 3);
		//eurasia
		MoveToEx(hDC, ptsBegin.x + 200, ptsBegin.y+ 20, (LPPOINT)NULL);
		LineTo(hDC, ptsBegin.x + 210, ptsBegin.y + 20);
		LineTo(hDC, ptsBegin.x + 250, ptsBegin.y );
		LineTo(hDC, ptsBegin.x + 290, ptsBegin.y + 10);
		LineTo(hDC, ptsBegin.x + 400, ptsBegin.y + 5);
		LineTo(hDC, ptsBegin.x + 400 - 10, ptsBegin.y + 5 +5);
		LineTo(hDC, ptsBegin.x + 400 - 10, ptsBegin.y + 5 + 5 + 30);
		LineTo(hDC, ptsBegin.x + 400 - 10 - 5, ptsBegin.y + 5 + 5 + 30 - 7);
		LineTo(hDC, ptsBegin.x + 400 - 10 - 5 - 5, ptsBegin.y + 5 + 5 + 30 - 5);
		LineTo(hDC, ptsBegin.x + 400 - 10 - 5 - 5 +2, ptsBegin.y + 5 + 5 + 30);
		LineTo(hDC, ptsBegin.x + 400 - 10 - 5 - 5 + 2, ptsBegin.y + 5 + 5 + 30 + 20);
		LineTo(hDC, ptsBegin.x + 400 - 10 - 5 - 5 + 2 - 15, ptsBegin.y + 5 + 5 + 30 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400-20-10 + 2 - 15, ptsBegin.y +5 + 5 + 5 + 30 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 10 + 2 - 25, ptsBegin.y + 5 + 5 + 30 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 10 + 2 - 30, ptsBegin.y + 30 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 10 + 2 - 40, ptsBegin.y + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 10 + 2 - 40, ptsBegin.y + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 40, ptsBegin.y - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 40 - 10 + 12 - 40, ptsBegin.y +10 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 40, ptsBegin.y + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 55, ptsBegin.y + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 20 - 40 - 10 + 2 - 75, ptsBegin.y +10 -40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 -145 + 2  -20, ptsBegin.y -10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 145 + 2 - 20-10, ptsBegin.y-5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 145 + 2 - 20 - 10, ptsBegin.y - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 145 + 2 - 20 - 10 -20, ptsBegin.y - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 145 + 2 - 20 - 10 - 20 -10, ptsBegin.y -10 - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		LineTo(hDC, ptsBegin.x + 400 - 145 + 2 - 20 - 10 - 20 - 10 +2, ptsBegin.y -20 - 10 - 5 - 10 + 10 - 40 + 20 - 20 + 40 + 20 + 35);
		//africa
		MoveToEx(hDC, ptsBegin.x + 210, ptsBegin.y + 60, (LPPOINT)NULL);
		LineTo(hDC, ptsBegin.x + 230, ptsBegin.y + 75);
		LineTo(hDC, ptsBegin.x + 250 +5, ptsBegin.y + 81);
		LineTo(hDC, ptsBegin.x + 250 + 15, ptsBegin.y + 110);
		LineTo(hDC, ptsBegin.x + 250 + 15 + 10, ptsBegin.y + 112);
		LineTo(hDC, ptsBegin.x + 250 + 5, ptsBegin.y + 160);
		LineTo(hDC, ptsBegin.x + 250 + 5 -30, ptsBegin.y + 180);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30, ptsBegin.y + 130);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 -10, ptsBegin.y + 130 -10);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 15, ptsBegin.y + 130 - 10);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 15-15, ptsBegin.y + 130 - 15);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 40, ptsBegin.y + 130 - 25 );
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 40, ptsBegin.y + 130 - 25 -25);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 40 +15, ptsBegin.y + 130 - 25 - 25 -20);
		LineTo(hDC, ptsBegin.x + 250 + 5 - 30 - 40 + 25, ptsBegin.y + 130 - 25 - 25 - 20);
		EndPaint(hwnd, &ps);
		ClipCursor(NULL);
		break;

	case WM_LBUTTONUP:
		GetClientRect(hwnd, &rcClient);
		ptClientUL.x = rcClient.left;
		ptClientUL.y = rcClient.top;

		ptClientLR.x = rcClient.right + 1;
		ptClientLR.y = rcClient.bottom + 1;
		ClientToScreen(hwnd, &ptClientUL);
		ClientToScreen(hwnd, &ptClientLR);


		SetRect(&rcClient, ptClientUL.x, ptClientUL.y,
			ptClientLR.x, ptClientLR.y);
		ClipCursor(&rcClient);

		hDC = GetDC(hwnd);
		ptsBegin = MAKEPOINTS(lParam);
		//south america
		MoveToEx(hDC, ptsBegin.x - 15, ptsBegin.y, (LPPOINT)NULL);
		LineTo(hDC, ptsBegin.x + 3, ptsBegin.y);
		LineTo(hDC, ptsBegin.x + +20, ptsBegin.y+20);
		LineTo(hDC, ptsBegin.x +20 + 10, ptsBegin.y + 20);
		LineTo(hDC, ptsBegin.x +30+ 10, ptsBegin.y + 20 + 10 );
		LineTo(hDC, ptsBegin.x +20, ptsBegin.y + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + 20 - 5 - 5 , ptsBegin.y + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + 20 - 5 - 5 -10, ptsBegin.y  +5 + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + 20 - 5 - 5 - 10, ptsBegin.y + 5+15 + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + 20 - 5 - 5 - 10 + 5, ptsBegin.y  +5+ 5 + 15 + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + 20 - 5 - 5 - 10 + 5, ptsBegin.y + 15 + 5 + 15 + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x +  - 5 - 5 - 10 + 5, ptsBegin.y+ 15 + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + -5 - 5 - 10 + 5 - 3, ptsBegin.y  + 20 + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + -5 - 5 - 10 + 5 - 3 -2, ptsBegin.y  + 20 + 10 + 20);
		LineTo(hDC, ptsBegin.x + -5 - 5 - 10 + 5 - 3 - 2 - 20, ptsBegin.y + 10 - 10  + 10 + 20);
		LineTo(hDC, ptsBegin.x  -15, ptsBegin.y );
		//australia
		MoveToEx(hDC, ptsBegin.x - 15 +350, ptsBegin.y + 50, (LPPOINT)NULL);
		LineTo(hDC, ptsBegin.x - 15 +350 -10, ptsBegin.y  +50 + 20);
		LineTo(hDC, ptsBegin.x - 15 + 350 - 10 - 10, ptsBegin.y + 50 + 10);
		LineTo(hDC, ptsBegin.x - 15 + 350 - 10 - 10 - 20, ptsBegin.y + 50 + 10 +5);
		LineTo(hDC, ptsBegin.x - 15 + 350 - 10 - 10 - 20  -15, ptsBegin.y  - 10+ 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 350 - 10 - 10 - 20 - 20, ptsBegin.y -25 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 360 - 10 - 10 - 20 - 20, ptsBegin.y - 30 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 360 +15 - 10 - 10 - 20 - 20, ptsBegin.y - 30 -4 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 +10 + 360 + 15 - 10 - 10 - 20 - 20, ptsBegin.y - 30 - 4 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 10 + 360 + 15 - 10 - 10 - 20 - 20 +5, ptsBegin.y + 5 - 30 - 4 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 10 + 360 + 15 - 10 - 10 - 20 - 20 + 5, ptsBegin.y  -10 + 5 - 30 - 4 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 10 + 360 + 15 -20 +2 - 20 - 20 + 5, ptsBegin.y +7 - 10 + 5 - 30 - 4 + 50 + 10 + 5);
		LineTo(hDC, ptsBegin.x - 15 + 10 + 360 + 15 - 20 + 2 -40 +26 , ptsBegin.y +17 + 7 - 10 + 5 - 30 - 4 + 50 + 10 + 5);




		



		EndPaint(hwnd, &ps);




		//fPrevLine = FALSE;
		ClipCursor(NULL);
		//ReleaseCapture();
		return 0;

	
	

	case WM_DESTROY: // если окошко закрылось, то:
		PostQuitMessage(NULL); // отправл€ем WinMain() сообщение WM_QUIT
		break;
	default:
		return DefWindowProc(hwnd, iMsg, wParam, lParam); // если закрыли окошко
	}


	return DefWindowProc(hwnd, iMsg, wParam, lParam); }

// ќсновна€ функци€ - аналог int main() в консольном приложении:
int WINAPI WinMain(HINSTANCE hInstance, //дескриптор экземпл€ра приложени€
	HINSTANCE hPrevInstance,// дескриптор предыдущего экземпл€ра приложени€
	LPSTR lpCmdLine,//указатель на начало командной строки, введенной при запуске программы.
	int nCmdShow) // режим отображени€ окна
{
	HWND hwnd;
	MSG msg;

	static TCHAR szWindowClass[] = _T("win32app");


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
	wcex.lpszClassName = szWindowClass;
	wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_APPLICATION));

	if (!RegisterClassEx(&wcex))
	{
		MessageBox(NULL,
			_T("Call to RegisterClassEx failed!"),
			_T("Win32 Guided Tour"),
			NULL);

		return 1;
	}


	// ‘ункци€ вывода окна с кнопкой "ќ " на экран (о параметрах позже)
	//
	//MessageBox(NULL, "hi!!!", "hi", MB_OK);
	hwnd = CreateWindow(szWindowClass, "WINAIP",
		WS_OVERLAPPEDWINDOW | WS_VISIBLE, // режимы отображени€ окошка
		500, // положение окна по оси х (по умолчанию)
		300, // позици€ окна по оси у (раз дефолт в х, то писать не нужно)
		500, // ширина окошка (по умолчанию)
		300, // высота окна (раз дефолт в ширине, то писать не нужно)
		NULL,
		NULL,
		hInstance,
		NULL);

	HWND hwndButton = CreateWindow(
		"BUTTON",  // Predefined class; Unicode assumed
		"04NCTKA",      // Button text
		WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,  // Styles
		10,         // x position
		10,         // y position
		90,        // Button width
		20,        // Button height
		hwnd,     // Parent window
		NULL,       // No menu.
		(HINSTANCE)GetWindowLong(hwnd, GWL_HINSTANCE),
		NULL);      // Pointer not needed.

	ShowWindow(hwnd,nCmdShow);
	UpdateWindow(hwnd);


	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return msg.wParam;


}
