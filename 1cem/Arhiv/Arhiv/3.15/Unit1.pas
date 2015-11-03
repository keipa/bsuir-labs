unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    Label8: TLabel;
    Edit5: TEdit;
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
Edit1.Text:='0,1';
Edit2.Text:='0,8';
Edit3.Text:='10';
Edit4.Text:='0,001';
Edit5.Text:='';
Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var y,M,a,b,h,s,w,x,eps:extended;
    k:integer;
begin
a:=StrToFloat(Edit1.Text);
b:=StrToFloat(Edit2.Text);
M:=StrToFloat(Edit3.Text);
eps:=StrToFloat(Edit4.Text);
x:=a;  h:=(b-a)/m;
Edit5.Text:=floattostrf(h,fffixed,8,2);
repeat
      w:=-1;    s:=0;    k:=0;
      repeat
         inc(k);
         w:=-w*sqr(x);
         s:=s+w/(2*k*(2*k-1));
       until abs(w)<eps;
       y:=x*arctan(x)-ln(sqrt(1+sqr(x)));
       Memo1.Lines.Add(FloatToStrF(x,fffixed,5,2)+
       '   '+FloatToStrF(s,fffixed,9,6)+
       '   '+FloatToStrF(y,fffixed,9,6)+
       '   '+IntToStr(k));
       x:=x+h;
    until x>b+1e-9;

end;
end.
