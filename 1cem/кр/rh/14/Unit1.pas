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
  a : mas;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : longint;
begin
  edit1.Text := '4';
  for i := 1 to 4 do StringGrid1.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to 4 do StringGrid1.cells[i,1] := '1';
  StringGrid1.Cells[0,0] := 'Мвссив А : ';
  StringGrid1.Cells[0,1] := ' a[i] = ';
  for i := 1 to 4 do StringGrid2.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to 4 do StringGrid2.cells[i,1] := '1';
  StringGrid2.Cells[0,0] := 'Массив b : ';
  StringGrid2.Cells[0,1] := ' b[i] = ';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : LongInt;
begin
  n := StrToInt(Edit1.text);
  StringGrid1.ColCount := n+1;
  StringGrid2.ColCount := n + 1;
  for i := 1 to n do StringGrid1.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to n do StringGrid1.cells[i,1] := '1';
  StringGrid1.Cells[0,0] := 'Мвссив А : ';
  StringGrid1.Cells[0,1] := ' a[i] = ';
  for i := 1 to n do StringGrid2.Cells[i,0] := 'i = ' + IntToStr(i);
  for i := 1 to n do StringGrid2.cells[i,1] := '1';
  StringGrid2.Cells[0,0] := 'Массив b : ';
  StringGrid2.Cells[0,1] := ' b[i] = ';


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : longint;
begin
  n := StrToInt(Edit1.Text);
  GetMem(a,n * SizeOf(Extended));
  for i := 1 to n do a[i] := strtofloat(StringGrid1.Cells[i,1]);
  Find(a,n);
  for i := 1 to n do StringGrid2.Cells[i,1] := floattostrf(a[i],ffFixed,8,3);
  FreeMem(a,SizeOf(Extended) * n);

end;

end.
