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
Edit1.Text:='0';
Edit2.Text:='1';
Edit3.Text:='0,1';
Edit4.Text:='0,0001';
Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b,h,s,w,x,eps:extended;
    k:integer;
begin
a:=StrToFloat(Edit1.Text);
b:=StrToFloat(Edit2.Text);
h:=StrToFloat(Edit3.Text);
eps:=StrToFloat(Edit4.Text);
x:=a;
repeat
      s:=1;    w:=1;   k:=0;
      repeat
         inc(k);
         w:=-w*x/k;
         s:=s+w;
       until abs(w)<eps;
       Memo1.Lines.Add(FloatToStrF(x,fffixed,5,2)+
       '   '+FloatToStrF(s,fffixed,9,6)+
       '   '+FloatToStrF(exp(-x),fffixed,9,6)+
       '   '+IntToStr(k));
       x:=x+h;
    until x>b+1e-9;

end;
end.
