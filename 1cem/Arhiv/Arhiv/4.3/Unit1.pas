unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Edit3: TEdit;
    StringGrid2: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
NMmax=10;
Type
Mas1=array[1..NMmax,1..NMmax] of extended;
Mas2=array[1..NMmax] of extended;
var
  Form1: TForm1;
  A:Mas1;
  B:Mas2;
  N,M,i,j,k,l,d:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
k:=2 ;
N:=4;
M:=4;
Edit1.Text:=FloatToStr(N);
Edit2.Text:=FloatToStr(M);
Edit3.Text:=FloatToStr(k);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
StringGrid2.RowCount:=N+1;
StringGrid1.Cells[0,0]:='Массив А';
StringGrid2.Cells[0,0]:='Массив B';
for i:=1 to N do
  StringGrid1.Cells[0,i]:='i='+IntToStr(i);
for j:=1 to M do
  StringGrid1.Cells[j,0]:='j='+IntToStr(j);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  k:=strToInt(Edit3.text);
  for i:=1 to N do
   for j:=1 to M do
    A[j,i]:=StrToFloat(StringGrid1.Cells[j,i]);
    d:=M div 2;
  for l:=1 to M do begin
    if (A[1,k]=A[M,k]) and (A[l,k]=A[M-l+1,k]) and (A[d,k]=A[M-d+1,k]) then
      B[k]:=1
      else B[k]:=0;
      StringGrid2.Cells[0,k]:=FloatToStr(B[k]);end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
N:=StrToInt(Edit1.text);
M:=StrToInt(Edit2.text);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
StringGrid2.RowCount:=N+1;
for i:=1 to N do
  StringGrid1.Cells[0,i]:='i='+IntToStr(i);
for j:=1 to M do
  StringGrid1.Cells[j,0]:='j='+IntToStr(j);
end;

end.
