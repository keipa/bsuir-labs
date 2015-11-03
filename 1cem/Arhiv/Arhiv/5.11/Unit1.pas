unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Edit2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 Type TMas=array[1..1] of integer;
      PMas=^TMas;
      TMas2=array[1..1] of pmas;
      pmas2=^tmas2;
 var
   Form1: TForm1;
   A:Pmas2;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   N:=3; Edit1.Text:=inttostr(N);
   M:=3; Edit2.Text:=inttostr(M);
   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=M+1;
   StringGrid1.Cells[0,0]:='  A';

 for i:=1 to N do
     StringGrid1.Cells[0,i]:='  i='+IntToStr(i);
 for i:=1 to m do
     StringGrid1.Cells[i,0]:='  j='+IntToStr(i);
    end;

procedure TForm1.Button1Click(Sender: TObject);
  begin
    N:=StrToInt(Edit1.Text);
    M:=StrToInt(Edit2.Text);
    StringGrid1.RowCount:=N+1;
    StringGrid1.ColCount:=M+1;
 for i:=1 to N do
     StringGrid1.Cells[0,i]:='  i='+IntToStr(i);
 for i:=1 to m do
     StringGrid1.Cells[i,0]:='  j='+IntToStr(i);
   end;

procedure TForm1.Button2Click(Sender: TObject);
var min,max:extended;
   begin
getmem(a,n*sizeof(integer));
for i:=1 to n do getmem(a[i],M*sizeof(integer));
for i:=1 to N do
  for j:=1 to M do
       A[i]^[j]:=ord(StringGrid1.Cells[j,i][1]);

for i:=1 to n do
 for j:=1 to m do
  if (a^[i]^[j]>=65) and (a^[i]^[j]<=90) then a^[i]^[j]:=a^[i]^[j]+32;

for i:=1 to n do
 for j:=1 to m do stringgrid1.Cells[j,i]:=chr(a^[i]^[j]);

for i:=1 to n do freemem(a[i],M*sizeof(integer));
freemem(a,n*sizeof(integer));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 randomize;
 for i:=1 to m do
  for j:=1 to n do
   stringgrid1.Cells[i,j]:=chr(random(93)+33);
end;

end.
