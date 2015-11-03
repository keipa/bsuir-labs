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
    Edit2: TEdit;
    Label5: TLabel;
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

function yR(x,n:integer):integer;
begin
 if n=1 then
  begin
   result:=x;
   exit;
  end;
 if odd(n) then result:=x*yR(x,n-1)
 else result:=sqr(yR(x,n div 2));
end;

function y(x,n:integer):integer;
var i,c:integer;
begin
 c:=1;
 for i:=1 to n do c:=c*x;
 result:=c;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 label2.caption:='';
 label3.caption:='';
 edit1.Text:='';
 edit2.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,n:integer;
begin
 if (edit1.Text<>'') and (edit2.Text<>'') then
  begin
   x:=strtoint(edit1.Text);
   n:=strtoint(edit2.Text);
  end
 else
  begin
   showmessage('Введите все значения!');
   Exit;
  end;
 label2.Caption:='C='+inttostr(yR(x,n))+' (рекурсия)';
 label3.Caption:='C='+inttostr(y(x,n));
end;

end.
