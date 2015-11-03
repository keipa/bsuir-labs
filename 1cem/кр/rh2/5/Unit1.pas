unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    chart2: TChart;
    Series1: TLineSeries;
    Button1: TButton;
    Series2: TLineSeries;
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
  n : LongInt;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.Text := '1';
  Edit2.Text := '2';
  edit3.Text := '10';
  chart2.SeriesList[0].Clear;
  chart2.SeriesList[1].Clear;
end;

function division( a,b : cmplx) : cmplx;
var
  res : cmplx;
begin
  res.r := (a.r * b.r + a.im * b.im) / (b.r * b.r + b.im*b.im);
  res.im := (a.r * b.im - a.im*b.r) / (b.r * b.r + b.im*b.im);
  division := res;
end;

function sx( x : Extended) : cmplx;
var
  a,b : cmplx;
begin
  sx.r := 1;
  sx.im := 1;
  a.r := 2;
  a.im := x;
  b.r := x;
  b.im := -2;
  sx := division(a,b);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  n := StrToInt(Edit3.Text);
  tabl(a,b,n,sx,chart2);
end;

end.
