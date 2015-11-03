unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
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
var
  Form1: TForm1;
  A:Mas1; i,j,N:integer;
  k,l,s,pr:extended;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
N:=4;
Edit1.Text:=FloatToStr(N);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=N+1;
StringGrid1.Cells[0,0]:='Массив А';
for i:=1 to N do
  StringGrid1.Cells[0,i]:='i='+IntToStr(i);
for j:=1 to N do
  StringGrid1.Cells[j,0]:='j='+IntToStr(j);
Memo1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
 begin
 Memo1.Clear;
for i:=1 to N do
   for j:=1 to N do
    A[j,i]:=StrToFloat(StringGrid1.Cells[j,i]);
    s:=0; pr:=1;
  for i:=1 to N-1 do
     for j:=1 to N-i do
      s:=s+A[j,i];
  for j:=1 to N-1 do
     for i:=j+1 to N do
     pr:=pr*A[j,i];
   Memo1.Lines.Add('s='+FloatToStr(s)+'   '+'pr='+FloatToStr(pr));

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
N:=StrToInt(Edit1.text);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=N+1;
for i:=1 to N do
  StringGrid1.Cells[0,i]:='i='+IntToStr(i);
for j:=1 to N do
  StringGrid1.Cells[j,0]:='j='+IntToStr(j);
end;

end.
