unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    RadiouGroup1: TRadioGroup;
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
  n : longint;
  k : Extended;
  a : mas;
  bm : Boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : LongInt;
begin
  memo1.Clear;
  edit1.text := '4';
  stringgrid1.Cells[0,0] := 'A : ';
  for i := 1 to 4 do StringGrid1.Cells[i,0] := 'i = ' +inttostr(i);
  stringgrid1.cells[0,1] := 'a[i] = ';
  for i := 1 to 4 do stringgrid1.cells[i,1] := '0';
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  i : longint;
begin
  n := StrToInt(Edit1.text);
  StringGrid1.ColCount := n + 1;
  for i := 1 to n do StringGrid1.Cells[i,0] := 'i = ' +inttostr(i);
  for i := 1 to n do stringgrid1.cells[i,1] := '0';
  Memo1.Clear;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  i : LongInt;
begin
  n := strtoint(Edit1.Text);
  GetMem(a, 4 * n * SizeOf(Extended));
  for i := 1 to n do a[i] := strtofloat(StringGrid1.Cells[i,1]);
  bm := radiougroup1.itemindex = 0;
  k := find(a,n,bm);
  Memo1.Lines.Add(FloatToStrf(K,ffFixed,8,3));
end;

end.
