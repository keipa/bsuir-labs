unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='';
Edit2.Text:='';
Edit3.Text:='';
Memo1.Clear;
RadioGroup1.ItemIndex:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,y,z,fx,fy,a:extended;
begin
x:=StrToFloat(Edit1.Text);
y:=StrToFloat(Edit2.Text);
z:=StrToFloat(Edit3.Text);
Memo1.Lines.Add('x='+FloatToStrF(x,fffixed,8,2));
Memo1.Lines.Add('y='+FloatToStrF(y,fffixed,8,2));
Memo1.Lines.Add('z='+FloatToStrF(z,fffixed,8,2));
case RadioGroup1.ItemIndex of
     0: begin fx:=sinh(x); fy:=sinh(y); end;
     1: begin fx:=sqr(x);  fy:=sqr(y); end;
     2: begin fx:=exp(x);  fy:=exp(y); end;
end;
if (3<x*y) and (x*y<8) then a:=ln(abs(x+fy)) else
 if x*y>12 then a:=cos(fx)-y else a:=sinh(fx+cos(y));
if CheckBox1.Checked
         then Memo1.Lines.Add('ответ='+IntToStr(Round(a)))
         else Memo1.Lines.Add('ответ='+FloatToStrF(a,fffixed,8,4));
end;
end.
