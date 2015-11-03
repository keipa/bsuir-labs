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

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : LongInt;
begin
  edit1.Text := '4';
  edit2.Text := '4';
  for i := 1 to 4 do StringGrid1.Cells[i,1] := '0';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : LongInt;
begin
  n := StrToInt(Edit1.Text);
  StringGrid1.ColCount := n+1;
  for i:=1 to n do StringGrid1.Cells[i,1] := '0';
  StringGrid2.ColCount := n+2;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  a : pmas;
  i : longint;
begin
  n := StrToInt(Edit1.Text);
  StringGrid2.ColCount := n+2;
  c := strtofloat(Edit2.Text);
  GetMem(a, (n+2) * SizeOf(Extended));
  for i := 1 to n do a[i] := strtofloat(Stringgrid1.cells[i,1]);
  Insert(a,n);
  for i := 1 to n+1 do StringGrid2.Cells[i,1] := FloatToStrf(a[i],ffFixed,8,3);
  FreeMem(a,(n+2) * SizeOf(Extended));
end;

end.
