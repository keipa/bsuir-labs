unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clipbrd, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);






  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure stopprog;
begin
Form1.close;
end;


procedure TForm1.FormCreate(Sender: TObject);
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
sleep(500);
stopprog;

end;









end.
