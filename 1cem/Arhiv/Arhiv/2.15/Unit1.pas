unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

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
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
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
Edit1.Text:='2';
Edit2.Text:='1';
Edit3.Text:='0';
Memo1.Clear;
Memo1.Lines.Add('Результаты Ящука.Г.А. 712502');
Radiogroup1.ItemIndex:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,y,z,f,min,r:extended;
begin
x:=StrToFloat(Edit1.Text);
Memo1.Lines.Add('X='+FloatToStrF(x,fffixed,8,4));
y:=StrToFloat(Edit2.Text);
Memo1.Lines.Add('Y='+FloatToStrF(y,fffixed,8,4));
z:=StrToFloat(Edit3.Text);
Memo1.Lines.Add('Z='+FloatToStrF(z,fffixed,8,4));
case RadioGroup1.ItemIndex of
0:f:=sinh(x);
1:f:=sqr(x);
2:f:=exp(x);
end;
if f>y then min:=y else min:=f;
if min>z then r:=min else r:=z;
Memo1.Lines.Add('R='+FloatToStrF(r,ffGeneral,8,4));
end;
end.
