#include <windows.h> // заголовочный файл, содержащий функции API
#include <stdlib.h>
#include <string.h>
#include <tchar.h>

TCHAR mainMessage[] = "text";

LRESULT CALLBACK WndProc(HWND hwnd, UINT iMsg, WPARAM wParam, LPARAM lParam){
	HDC hDC; // создаЄм дескриптор ориентации текста на экране
	PAINTSTRUCT ps; // структура, сод-ща€ информацию о клиентской области (размеры, цвет и тп)
	RECT rect; // стр-ра, определ€юща€ размер клиентской области
	COLORREF colorText = RGB(0, 0, 255); // задаЄм цвет текста
	switch (iMsg){
	case WM_PAINT: // если нужно нарисовать, то:
		hDC = BeginPaint(hwnd, &ps); // инициализируем контекст устройства
		GetClientRect(hwnd, &rect); // получаем ширину и высоту области дл€ рисовани€
		SetTextColor(hDC, colorText); // устанавливаем цвет контекстного устройства
		DrawText(hDC, mainMessage, -1, &rect, DT_SINGLELINE | DT_CENTER | DT_VCENTER); // рисуем текст
		EndPaint(hwnd, &ps); // заканчиваем рисовать
		break;
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
	hwnd = CreateWindow(szWindowClass, "proc",
		WS_OVERLAPPEDWINDOW | WS_VISIBLE, // режимы отображени€ окошка
		200, // положение окна по оси х (по умолчанию)
		200, // позици€ окна по оси у (раз дефолт в х, то писать не нужно)
		300, // ширина окошка (по умолчанию)
		100, // высота окна (раз дефолт в ширине, то писать не нужно)
		NULL,
		NULL,
		hInstance,
		NULL);

	ShowWindow(hwnd,nCmdShow);
	UpdateWindow(hwnd);


	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return msg.wParam;


}
