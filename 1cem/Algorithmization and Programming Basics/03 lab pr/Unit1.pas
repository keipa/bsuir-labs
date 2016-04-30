unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='0';
Edit2.Text:='2';
Edit3.Text:='0,25';
Edit4.Text:='0,001';
end;

procedure TForm1.Button1Click(Sender: TObject);

var xn,xk,x,h,e,a,s,y:extended;
n,k:integer;
begin
memo1.clear;
xn:=strtofloat(EDIT1.TExt);
memo1.lines.add('xn='+floattostrf(xn,fffixed,6,2));
xk:=strtofloat(EDIT2.TExt);
memo1.lines.add('xk='+floattostrf(xk,fffixed,6,2));
h:=strtofloat(EDIT3.TExt);
memo1.lines.add('h='+floattostrf(h,fffixed,8,3));
e:=strtofloat(EDIT4.TExt);
memo1.lines.add('e='+floattostrf(e,fffixed,8,5));
x:=xn;
repeat
a:=1; s:=1; n:=0;
while (abs(a)>e) do begin
n:=n+1;
a:=-a*x/n;
S:=s+a;
end;
e:=exp(-x);
memo1.lines.add('if x=' +floattostrf(x,fffixed,6,2)+'   sum ='+floattostrf(s,fffixed,8,4)+ '  y=' + floattostrf(y,fffixed,8,4)+ '  n=' + inttostr(n));
x:=x+h;
until x>xk+h/2
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
close;
end;

end.
