

#include "stdafx.h"
#include "odib.h"
#include "resource.h"

int myManageOwnerDrawIconButton(DRAWITEMSTRUCT* pdis, HINSTANCE hInstance) {
	
	static RECT rect;
	static iCount = 0;
	TCHAR s[BUFFSIZE];
	
	
	static HICON hCurrIcon, hUpIconI, hDnIconI, hUpIconA, hDnIconA;
	
	
	rect = pdis->rcItem;
	
	if (iCount < 1) {
		
		
		iCount++;
		
		hUpIconI = (HICON) LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ODIB));
		if (!hUpIconI) {
			_stprintf(s, _T("! hUpIconI NULL (myManageOwnerDrawIconButton)"));
			myWriteToLog(s);
		}
		
		hDnIconI = (HICON) LoadIcon(hInstance, MAKEINTRESOURCE(ID_DN_ICONI));
		if (!hDnIconI) {
			_stprintf(s, _T("! hDnIconI NULL (myManageOwnerDrawIconButton)"));
			myWriteToLog(s);
		}
		
		
		hUpIconA = (HICON) LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ODIB));
		if (!hUpIconA) {
			_stprintf(s, _T("! hUpIconA NULL (myManageOwnerDrawIconButton)"));
			myWriteToLog(s);
		}
		
		hDnIconA = (HICON) LoadIcon(hInstance, MAKEINTRESOURCE(ID_DN_ICONA));
		if (!hDnIconA) {
			_stprintf(s, _T("! hDnIconA NULL (myManageOwnerDrawIconButton)"));
			myWriteToLog(s);
		}
	}
	
	
	if (IDC_LEVELUPBUTTON == pdis->CtlID) {
		
		
		if (pdis->itemState & ODS_SELECTED) hCurrIcon = hUpIconA;
		else hCurrIcon = hUpIconI;
	}
	
	
	if (IDC_LEVELDNBUTTON == pdis->CtlID) {
		
		
		if (pdis->itemState & ODS_SELECTED) hCurrIcon = hDnIconA;
		else hCurrIcon = hDnIconI;
	}
	
	
	if (!DrawIconEx(
		pdis->hDC,
		(int) 0.5 * (rect.right - rect.left - ICON_WIDTH),
		(int) 0.5 * (rect.bottom - rect.top - ICON_HEIGHT),
		(HICON) hCurrIcon,
		ICON_WIDTH,
		ICON_HEIGHT,
		0, NULL, DI_NORMAL
	)) {
		_stprintf(s, _T("! %ld from DrawIconEx (myManageOwnerDrawIconButton)"), GetLastError());
		myWriteToLog(s);
	}
	
	return(RET_OK);
}



/************************************
* To write a string into a log file *
* with current date and time        *
************************************/
int myWriteToLog(TCHAR* s) {
	long nTime;
	struct tm *tmDateTime;
	TCHAR sDateTime[6][16];
	FILE *f;
	
	if (NULL == s) return(0);
	time(&nTime);
	tmDateTime = (struct tm*) localtime(&nTime);
	f = _tfopen(sLogFileName, _T("a+"));
	if (!f) return(0);
	
	_tcsftime(sDateTime[0], 16, _T("%B"), tmDateTime);
	_tcsftime(sDateTime[1], 16, _T("%d"), tmDateTime);
	_tcsftime(sDateTime[2], 16, _T("%Y"), tmDateTime);
	_tcsftime(sDateTime[3], 16, _T("%H"), tmDateTime);
	_tcsftime(sDateTime[4], 16, _T("%M"), tmDateTime);
	_tcsftime(sDateTime[5], 16, _T("%S"), tmDateTime);
	
	
	_ftprintf(f, _T("%s (%s %s, %s @ %s:%s:%s)\n"), s, sDateTime[0], sDateTime[1], sDateTime[2], sDateTime[3], sDateTime[4], sDateTime[5]);
	
	if (f) fclose(f);
	return(1);
}


