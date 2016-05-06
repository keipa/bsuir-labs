unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Button2: TButton;
    Label2: TLabel;
    Edit2: TEdit;
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
  n : LongInt;
  c : Extended;
  a : mas;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : LongInt;
begin
  edit1.text := '3';
  edit2.text := '2';
  stringgrid1.Cells[0,0] := ' A : ';
  for i := 1 to 3 do StringGrid1.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to 3 do StringGrid1.Cells[i,1] := '0';
  StringGrid1.Cells[0,1] := 'a[i] = ';
  stringgrid2.Cells[0,0] := ' A : ';
  for i := 1 to 4 do StringGrid2.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to 4 do StringGrid2.Cells[i,1] := '0';
  StringGrid2.Cells[0,1] := 'b[i] = ';


end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : LongInt;
begin
  n := strtoint(edit1.Text);
  stringgrid1.ColCount := n+1;
  StringGrid2.ColCount := n +2;
  stringgrid1.Cells[0,0] := ' A : ';
  for i := 1 to n do StringGrid1.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to n do StringGrid1.Cells[i,1] := '0';
  StringGrid1.Cells[0,1] := 'a[i] = ';
  stringgrid2.Cells[0,0] := ' A : ';
  for i := 1 to n+1 do StringGrid2.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to n+1 do StringGrid2.Cells[i,1] := '0';
  StringGrid2.Cells[0,1] := 'b[i] = ';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : LongInt;
begin
  n := StrToInt(Edit1.Text);
  c := strtofloat(edit2.text);
  GetMem(a,(n+1) * sizeof(Extended));
  for i := 1 to n do a[i] := StrToFloat(StringGrid1.Cells[i,1]);
  ins(a,n,c);
  stringgrid2.colcount := n+1;
  for i := 1 to n do stringgrid2.cells[i,1] := floattostrf(a[i],fffixed,8,3);
  FreeMem(a,(n+1) * sizeof(Extended));
end;

end.
