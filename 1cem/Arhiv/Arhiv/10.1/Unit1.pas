unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function yR(n:integer):integer;
begin
 if n=0 then result:=1 else
  result:=n*yR(n-1);
end;

function y(n:integer):integer;
var i:integer;
    y:integer;
begin
 y:=1;
 for i:=1 to n do
  y:=y*i;
 result:=y;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 label2.caption:='';
 label3.caption:='';
 edit1.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var n:integer;
begin
 if edit1.Text<>'' then
  n:=strtoint(edit1.Text)
 else
  begin
   showmessage('Введите значение!');
   Exit;
  end;
 label2.Caption:='n!='+inttostr(yr(n))+' (рекурсия)';
 label3.Caption:='n!='+inttostr(y(n));
end;

end.
