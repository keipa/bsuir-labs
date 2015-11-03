unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.text:='0,1';
Edit2.text:='1';
Edit5.text:='10';
Edit4.text:='0,0001';
Edit3.Text:='';
Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
m,a,b,h,x,w,s,eps:extended;
k:integer;
begin
Memo1.Clear;
a:=strtofloat(Edit1.text);
b:=strtofloat(Edit2.text);
m:=strtofloat(Edit5.text);
eps:=strtofloat(Edit4.text);
x:=a; H:=(b-a)/m;
edit3.Text:=floattostrf(h,fffixed,8,2);
repeat
  s:=x ; w:=x; k:=0;
  repeat
    inc(k) ;
    w:=w*Sqr(x)/((2*k)*(2*k+1));
    s:=s+w;
  until abs(w)<eps;
 Memo1.Lines.Add(FloatToStrF(x,fffixed,5,2)+
'                '+FloatToStrF(s,fffixed,9,6)+
'             '+FloatToStrF((exp(x)-exp(-x))/2,fffixed,9,6)+
'                    '+intToStr(k));
  x:=x+h;
  until  x>b+1E-9;
end;

end.
