unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,unit2, Series;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a,b : Extended;
  n,m : LongInt;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.Text := '1';
  Edit2.Text := '3';
  edit3.Text := '10';
  Edit4.Text := '10';
end;

function sx( x : Extended) : Extended;
var
  i,k : LongInt;
  q, ans : Extended;
begin
  q := 1;
  ans := 1;
  for i := 1 to m do begin
    q := q * x / i;
    ans := ans + q;
  end;
  sx := ans;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  xomin,xomax,yomin,yomax,hx,hy : Extended;
  dx,dy,xmax,ymax : LongInt;
  q,cx,h,rt: Extended;
  i : LongInt;
  x,y : LongInt;
begin
  m := strtoint(Edit4.Text);
  n := strtoint(Edit3.Text);
  a := strtofloat(Edit1.Text);
  b := strtofloat(Edit2.Text);
  image2.Picture := nil;
  xomin := a;
  xomax := b;
  yomin := sx(a);
  yomax := sx(b);
  with image2.Canvas do begin
    Pen.Color := clBlack;
    xmax := image2.Width;
    ymax := image2.Height;
    TextOut(0,0,'ymax=' +floattostrf(yomax,ffFixed,8,3));
    TextOut(xmax - 70, ymax-20,'xmax = ' + FloatToStrF(xomax,ffFixed,8,3));
    TextOut(80,ymax - 20,'xmin=' +floattostrf(xomin,ffFixed,8,3));
    TextOut(0,ymax - 40,'ymin=' + FloatToStrF(yomin,ffFixed,8,3));
    MoveTo(70,0);
    LineTo(70,ymax);
    MoveTo(0,ymax - 25);
    LineTo(xmax,ymax - 25);
    Pen.Color := clRed;
    Pen.Width := 2;
    dx := 70;
    dy := ymax - 25;
    hx := (b - a) / (xmax  - dx);
    hy := (yomax - yomin) / dy;
    cx := a;
    q := sx(cx);
    MoveTo(1,1);
    LineTo(100,100);
    y := Round(dy - (-yomin+q)/hy);
    MoveTo(Round(dx),y);
    h := (b-a) / n;
    for i :=1 to n do begin
      cx := cx + h;
      q := sx(cx);
      x := Round(dx + (cx-a) / hx);
      y := Round(dy - (-yomin + q) / hy);
      LineTo(x,y);
    end;

  end;

end;


end.
