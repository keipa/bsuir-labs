unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, Clipbrd;
var Pr:TPr;

    okno1:TImage;
    pxm1,pym1,xo,yo,ro,doo:word;

procedure TForm1.Button6Click(Sender: TObject);  //Нарисовать
begin
  okno1:=Form1.Image1;
  colrBack:=clWhite;
  pxm1:=okno1.ClientWidth;
  pym1:=okno1.ClientHeight;
  with okno1.canvas do
    begin
      pen.color:=colrBack;
      brush.color:=colrBack;
      Rectangle(0,0,pxm1,pym1);
    end;
  xo:=pxm1 div 2;
  yo:=pym1 div 2;
  ro:=50;
  doo:=30;
  Pr:=TPr.Create(xo,yo,2*ro,doo,clBlack,okno1.Canvas);
  ro:=10;
  Pr.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);  //Вверх
begin
  Pr.MovTo(0,-5,0);
end;

procedure TForm1.Button3Click(Sender: TObject); //Влево
begin
   Pr.MovTo(-5,0,0);
end;

procedure TForm1.Button2Click(Sender: TObject);  //Вниз
begin
   Pr.MovTo(0,5,0);
end;

procedure TForm1.Button4Click(Sender: TObject);  //Вправо
begin
   Pr.MovTo(5,0,0);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);   //Close
begin
  Pr.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);    //Выпустить дым
begin
  Image1.Canvas.Pen.Color:=clBlack;
  Image1.Canvas.Brush.Color:=clBlack;
  Pr.Dim;
  okno1.Update;
  Sleep(1000);
  Image1.Canvas.Pen.Color:=clWhite;
  Image1.Canvas.Brush.Color:=clWhite;
  Pr.Dim;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);     //Копировать
begin
   ClipBoard.Assign(Image1.Picture);
end;

end.
