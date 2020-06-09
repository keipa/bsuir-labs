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
    chart2: TChart;
    Series1: TLineSeries;
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
  Edit2.Text := '2';
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
begin
  chart2.SeriesList[0].Clear;
  m := strtoint(Edit4.Text);
  n := strtoint(Edit3.Text);
  a := strtofloat(Edit1.Text);
  b := strtofloat(Edit2.Text);
  with chart2 do begin
    LeftAxis.Automatic := True;
    BottomAxis.Automatic := true;
  end;
  Draw(a,b,n,sx,chart2);
end;

end.
