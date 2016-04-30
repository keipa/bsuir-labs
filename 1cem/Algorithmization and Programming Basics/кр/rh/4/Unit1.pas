unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a : mas;
  x,ans : Extended;
  n : longint;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : LongInt;
begin
  Edit1.Text :='4';
  Edit2.Text :='1';
  for i :=0 to 5 do StringGrid1.Cells[i,0] := ' a[' + IntToStr(i) +'] ' ;
  for i := 0 to 5 do StringGrid1.Cells[i,1] := '1';
  Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : longint;
begin
  memo1.clear;
  n := strtoint(edit1.text);
  setlength(a,n+1);
  for i := 0 to n do a[i] := strtofloat(stringgrid1.cells[i,1]);
  x := strtofloat(edit2.text);
  ans :=0;
  ans := find(x, n, a);
  memo1.lines.add('P(x) = ' + floattostrf(ans,fffixed,8,3));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : LongInt;
begin
  n := StrToInt(Edit1.text);
  StringGrid1.ColCount := n + 1;
  for i :=0 to n do StringGrid1.Cells[i,0] := ' a[' + IntToStr(i) +'] ' ;
  for i := 0 to n do StringGrid1.Cells[i,1] := '1';
  Memo1.Clear;
end;

end.
