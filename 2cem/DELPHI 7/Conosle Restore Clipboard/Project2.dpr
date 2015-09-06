program Project2;

{$APPTYPE CONSOLE}

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Clipbrd,
  StdCtrls,
  Buttons;

var  f:TextFile;
      str,fulstr:string;
begin
AssignFile(f, 'saveme.txt');
Reset(f);
while not Eof(f)  do
begin
readln(f, str);
fulstr:=fulstr+#10#13+str;
end;
Clipboard.AsText:=  fulstr;
CloseFile(f);



end.



