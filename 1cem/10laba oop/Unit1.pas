unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    img1: TImage;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TBitBtn;
    btn7: TButton;
    btn8: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;
var 
Wheel:TWheelMove;
pxm1,pym1, xo,yo,ro:word;
{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
wind:=Form1.img1;
colrBack:=clWhite;
pxm1:=img1.ClientWidth;
pym1:=img1.ClientHeight;
xo:=pxm1 div 2; yo:=pym1 div 2;
ro:=10
Wheel:=TWheelMove.Create(xo,yo,ro,clBlack,wind.img1);
wheel.show;
wheel.rotate(True);
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
wind.MovTo(0,0,3);
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
wind.MovTo(0,0,-3);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
wind.MovTo(0,7,0);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
wind.MovTo(0,-7,0);
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
wind.MovTo(-7,0,0);
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
 wind.MovTo(7,0,0);
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
wind.free;
end;

end.
