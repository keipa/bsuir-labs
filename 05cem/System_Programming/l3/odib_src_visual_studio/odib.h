
/****************************************************************************************
* (c) Bruno Challier 2007                                                               *
* This code is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY. *
* ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY DISCLAIMED.                             *
* This includes but is not limited to warranties of MERCHANTABILITY or FITNESS FOR A    *
* PARTICULAR PURPOSE.                                                                   *
****************************************************************************************/

#ifndef __ODIB_H__
#define __ODIB_H__

	#define _UNICODE
	#define UNICODE
	
	// Application name and name of log file:
	static TCHAR sAppName[] = _T("odib");
	static TCHAR sLogFileName[] = _T("odib_log.txt");
	
	// Return values:
	#define RET_OK 1
	#define RET_ERR_CREATE -1
	#define RET_ERR_LOAD_ICON -2
	
	#define BUFFSIZE 2048
	
	// A macro "shortcut" for a general-purpose message dialog:
	#define msgb(x) \
MessageBox(NULL, (LPCTSTR) x, \
(LPCTSTR) sAppName, \
(UINT) MB_OK | MB_ICONINFORMATION | MB_APPLMODAL)
	
	// Width and height values:
	#define MARGIN 2
	#define ICON_WIDTH 32
	#define ICON_HEIGHT 32
	
	// Miscellaneous:
	#define STR_ABOUT _T("About \'odib\'")

	// Handles:
	static HWND hLevelUpButton, hLevelDnButton, hDisplayEdit, hBackgroundStatic;

	/*************************
	* Functions declarations *
	*************************/
	
	// In file odib_misc.c:
	int myManageOwnerDrawIconButton(
		DRAWITEMSTRUCT* pdis,
		HINSTANCE hInstance);
	
	int myWriteToLog(TCHAR* s);
	
	// String constant for the help menu, item 'About':
	#define TEXT_HELP_ABOUT _T("\
\'odib\':\015\012\
Icon-based owner draw buttons\015\012\
Click the buttons or select menu items to\015\012\
display a string in the readonly edit control\015\012\
(c) Bruno Challier - 2007\015\012\015\012")

#endif  /* __ODIB_H__ */

