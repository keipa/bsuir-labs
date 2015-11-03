unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
var a,b,u,o,res,i:integer;
begin
  a:=strtoint(edit1.Text);
  b:=strtoint(edit2.Text);
if a>b then
begin

u:=b;
o:=a;
end
else
begin
o:=b;
U:=a;
end;

if radiogroup1.ItemIndex=0 then

  begin
  memo1.Clear;
  memo1.Lines.add('SEARCH NOD OF '+intToStr(a)+' and '+intToStr(b)+':');
  for i:=1 to u do
  begin
    if (a mod i = 0)  and (b mod i = 0) then
    res:=i;
  end;
  memo1.Lines.add('NOD IS '+intToStr(res))
  end;

if radiogroup1.ItemIndex=1 then
  Begin
  memo1.Clear;
  memo1.Lines.add('SEARCH NOK OF '+intToStr(a)+' and '+intToStr(b)+':');
  for i:=a*b downto o do
  begin
    if (i mod a = 0) and (i mod b = 0) then
    res:=i;

  end;
  memo1.Lines.add('NOK IS '+intToStr(res))
  end;

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear;
end;

end.
