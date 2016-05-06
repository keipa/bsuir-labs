unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
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
edit1.Text:='0.1';
edit2.Text:='0.356';
memo1.clear;
radiogroup1.ItemIndex:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,y,u,max:extended ;
begin
x:=strtofloat(edit1.text);
y:=strtofloat(edit2.text);
memo1.lines.add('results: Rovdo Nicolai 453504 ');
memo1.lines.add('x=='+floattostrf(x,fffixed,8,4));
memo1.lines.add('y=='+floattostrf(y,fffixed,8,4));
case radiogroup1.itemindex of
0: u:=sin(x);
1: u:=sqr(x);
2: u:=exp(x);
end;
if x*y=0 then max:=sqr(u+y)+1;
if x*y>0 then max:=sqr(u+y)-sqrt(u*y);
if x*y<0 then max:=sqr(u+y)+sqrt(abs(u*y));
if checkbox1.checked then
memo1.lines.add ('a (OKP)= '+inttostr(round(max)))
else
memo1.lines.add('a (HE OKP)= '+ floattostrf(max,ffGeneral,8,2));

end;


end.     
