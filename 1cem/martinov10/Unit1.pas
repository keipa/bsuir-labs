unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Timer: TTimer;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
implementation
{$R *.dfm}

uses Unit2, ClipBrd;
var
 Pram:Tpram;
 Krug1,Krug2:Tkrug;
 pxm1,pym1,Xo,Yo,Ro1,Ro2:word;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Timer.Enabled := false;
 colrBack:=clWhite;
 pxm1:=Image1.ClientWidth;
 pym1:=Image1.ClientHeight;
 with Image1.Canvas do
  begin
   Pen.Color:=colrBack;
   Brush.Color:=colrBack;
   Rectangle(0,0,pxm1,pym1);
  end;
 Xo:=pxm1 div 2;
 Yo:=pym1 div 2;
 Ro1:=34;
 Ro2:=15;
 Pram:=Tpram.Create(Xo,Yo,Ro1,clBlack,Image1.Canvas);
 Krug1:=Tkrug.Create(Xo-3*Ro2,Yo+Ro2,Ro2,clBlack,Image1.Canvas);
 Krug2:=Tkrug.Create(Xo+3*Ro2,Yo+Ro2,Ro2,clBlack,Image1.Canvas);
 with Image1.Canvas do
  begin
   Pen.Color:=clBlack;
   Pen.Width:=2;
   MoveTo(0,Yo+2*Ro2+1);
   LineTo(Image1.Width,Yo+2*Ro2+1);
  end;
 Pram.Show;
 Krug1.Show;
 Krug2.Show;
 Timer.Tag := 0;
 Timer.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Timer.Tag := 1;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Timer.Tag := -1;
end;

procedure TForm1.TimerTimer(Sender: TObject);
begin
  if ((Timer.Tag < 0) and (Pram.x1 > 3)) or
    ((Timer.Tag > 0) and (Pram.x2 < Image1.Width)) then
  begin
  if Timer.Tag > 0 then
  begin
    Pram.MovTo(3,0,0);
    Krug1.MovTo(3,0,0);
    Krug2.MovTo(3,0,0);
  end
  else if Timer.Tag < 0 then
  begin
    Pram.MovTo(-3,0,0);
    Krug1.MovTo(-3,0,0);
    Krug2.MovTo(-3,0,0);
  end;
  end else
  begin
    if Timer.Tag < 0 then Timer.Tag := 1
    else if Timer.Tag > 0 then Timer.Tag := -1;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 Timer.Tag := 0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 Timer.Enabled := false;
 Timer.Tag := 0;
 Pram.Free;
 Krug1.Free;
 Krug2.Free;
end;

end.
