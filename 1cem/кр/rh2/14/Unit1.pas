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
    StringGrid3: TStringGrid;
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
  a,b,cc : pmas;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.Text := '4';
  edit2.Text := '4';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  n,m,i : LongInt;
begin
  n :=  StrToInt(Edit1.Text);
  m := StrToInt(Edit2.Text);
  StringGrid1.ColCount := n+1;
  StringGrid2.ColCount := m+1;
  StringGrid3.ColCount := n+m+1;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  n,m,i : LongInt;
  q : Extended;
begin
  n :=  StrToInt(Edit1.Text);
  m := StrToInt(Edit2.Text);
  StringGrid1.ColCount := n+1;
  StringGrid2.ColCount := m+1;
  StringGrid3.ColCount := n+m+1;
  GetMem(a,(n+1) * SizeOf(Extended));
  GetMem(b,(m+1) * SizeOf(Extended));
  GetMem(cc,(n+m+1) * SizeOf(Extended));
  for i := 1 to n do a[i] := StrToFloat(StringGrid1.Cells[i,1]);
  for i := 1 to m do b[i] := StrToFloat(StringGrid2.Cells[i,1]);
  merge_sort(a,b,n,m,cc);
  for i := 1 to n+m do begin
    StringGrid3.Cells[i,1] := FloatToStrF(cc[i],ffFixed,8,3)
  end;
end;

end.
