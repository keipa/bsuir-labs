unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    image2: TImage;
    Button1: TButton;
    Edit4: TEdit;
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
  edit1.text := '0';
  edit2.Text := '0';
  Edit3.Text := '10';
  image2.Picture := nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  hx : Extended;
  xx,yy,rr : Extended;
  xo,yo,xmax,ymax,x,y,r : LongInt;
begin
  xx := StrToFloat(Edit1.Text);
  yy := StrToFloat(Edit2.Text);
  rr := StrToFloat(Edit3.Text);
  xmax := image2.Width;
  ymax := image2.Height;
  xo := xmax div 2;
  yo := ymax div 2;
  hx := StrToFloat(edit4.text);
  x  := Round(xo + xx/hx);
  y := Round(yo + yy/hx);
  r := Round(rr/hx);
  with image2.Canvas do begin
    //2*r = (2/3)xmax
    //hx := (2*r) / (2/3*xmax);
   // Ellipse(xo-r/hx,yo+)
    Pen.Width := 4;
    Pen.Color := clBlack;
    Brush.Color := clWhite;
    Rectangle(0,0,xmax,ymax);
    Brush.Color := clGreen;
    Pen.Color := clRed;
    Ellipse(xo - r,yo - r,xo + r,yo + r);
  end;

end;

end.
