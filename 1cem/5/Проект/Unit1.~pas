unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, Math;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    StringGrid2: TStringGrid;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type
  TMas=array[1..1] of integer;
  PMas=^TMas;

var
  Form1: TForm1;
  i,N,j,M,k:integer;
  a:PMas;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=9;
  StringGrid1.Cells[0,0]:='Исх. мас.';
  StringGrid2.Cells[0,0]:='Вых. мас.';
  Randomize;
  for i:=1 to N do
    StringGrid1.Cells[i,0]:=Chr(RandomRange(97,122));

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  GetMem(a,N*sizeof(integer));
  for i:=1 to N do
    a[i]:=Ord(StringGrid1.Cells[i,0][1]);
  for i:=1 to N-1 do
    for j:=i+1 to N do
      if a[i]=a[j] then
        begin
          for k:=j to N-1 do
            a[k]:=a[k+1];
          N:=N-1;
        end;
  for i:=1 to N-1 do
    for j:=i+1 to N do
      if a[i]>a[j] then
        begin
          M:=a[i];
          a[i]:=a[j];
          a[j]:=M;
        end;
  StringGrid2.ColCount:=N;
  for i:=1 to N do
    StringGrid2.Cells[i,0]:=Chr(a[i]);
  FreeMem(a,N*sizeof(integer));
end;

end.
