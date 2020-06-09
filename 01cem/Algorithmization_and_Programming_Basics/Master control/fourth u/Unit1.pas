unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Unit2, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    img1: TImage;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var

  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.btn1Click(Sender: TObject);
var

a,b,n:Integer;

begin
xmin:=0;
ymin:=0;
ymax:=img1.Height;
xmax:=img1.width;
a:=StrToInt(edt1.text);
b:=StrToInt(edt2.text);
n:=StrToInt(edt3.text);
m:=StrToInt(edt4.text);

with img1.Canvas do begin
     Pen.Color:=clBlack;
     MoveTo(0,ymax-20);
     LineTo(xmax,ymax-20);
     moveto(20,0);
     LineTo(20,ymax);
     pen.color:=clred;
     graph(a,b,n,xmax,ymax,img1);
  end;

end;

end.
