unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
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
  A : mas;
  n, n1: longint;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : longint;
begin
  Edit1.Text := '4';
  StringGrid1.Cells[0,0] := ' Massiv A : ';
  for i := 1 to 4 do StringGrid1.cells[i,0] := 'i = ' +IntToStr(i);
  for i := 1 to 4 do StringGrid1.Cells[i,1] := '0';
  StringGrid1.Cells[0,1] := ' A[i] =';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : LongInt;
begin
  n := StrToInt(Edit1.Text);
  GetMem(a, 4 * SizeOf(longint) * n);
  for i := 1 to n do a[i] := StrToint(StringGrid1.Cells[i,1]);
  n1 := 0;
  Calculate(n,n1,a);
  //for i := 1 to n do StringGrid2.Cells[i,1] := intToStr(a[i]);
  StringGrid2.ColCount := n1+1;
  for i := 1 to n1 do StringGrid2.Cells[i,0] := 'i = ' +inttostr(i);
  StringGrid2.Cells[0,0] := 'Massiv B';
  StringGrid2.Cells[0,1] := 'b[i] = ';
  for i := 1 to n1 do StringGrid2.Cells[i,1] := IntToStr(a[i]);

  
  FreeMem(a,4*sizeof(longint) * n);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : LongInt;
begin
  n := strtoint(Edit1.Text) + 1;
  StringGrid1.ColCount := n;
  StringGrid1.Cells[0,0] := ' Massiv A : ';
  for i := 1 to n do StringGrid1.cells[i,0] := 'i = ' +IntToStr(i);
  for i := 1 to n do StringGrid1.Cells[i,1] := '0';
  StringGrid1.Cells[0,1] := ' A[i] =';
end;

end.
