unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    Button2: TButton;
    StringGrid2: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


const q=100;

type mat=array[1..q,1..q] of integer;

var
  Form1: TForm1;
  a:mat;
  maxi,maxj,i,j,m,n:integer;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
N:=3; edit1.Text:=inttostr(n);
M:=3; edit2.Text:=inttostr(m);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
StringGrid2.RowCount:=N;
StringGrid2.ColCount:=M;
StringGrid1.Cells[0,0]:='  A';
StringGrid2.Cells[0,0]:='  B';
for i:=1 to N do
 begin
  StringGrid1.Cells[0,i]:=' i='+inttostr(i);
  StringGrid2.Cells[0,i]:=' i='+inttostr(i);
 end;
for j:=1 to M do
 begin
  StringGrid1.Cells[j,0]:=' j='+inttostr(j);
  StringGrid2.Cells[j,0]:=' j='+inttostr(j);
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
N:=StrToInt(Edit1.Text);
M:=StrToInt(Edit2.Text);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
StringGrid2.RowCount:=N;
StringGrid2.ColCount:=M;
for i:=1 to N do
 begin
  StringGrid1.Cells[0,i]:=' i='+inttostr(i);
  StringGrid2.Cells[0,i]:=' i='+inttostr(i);
 end;
for j:=1 to M do
 begin
  StringGrid1.Cells[j,0]:=' j='+inttostr(j);
  StringGrid2.Cells[j,0]:=' j='+inttostr(j);
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
try
 for i:=1 to n do
  for j:=1 to m do
   a[i,j]:=strtoint(stringgrid1.cells[j,i]);
 maxi:=1;
 maxj:=1;
 for i:=1 to n do
  for j:=1 to m do
   if abs(a[i,j])>abs(a[maxi,maxj]) then
    begin
     maxi:=i;
     maxj:=j;
    end;

 if maxi<>n then
  for i:=maxi to n-1 do
   for j:=1 to m do a[i,j]:=a[i+1,j];

 if maxj<>m then
  for j:=maxj to m-1 do
   for i:=1 to n do a[i,j]:=a[i,j+1];

 for i:=1 to n-1 do
  for j:=1 to m-1 do
   stringgrid2.cells[j,i]:=inttostr(a[i,j]);
except
    on ERangeError do
     begin
      showmessage('Выход за пределы массива.Уменьшите размер массива');
      Exit;
     end;
    on EConvertError do
     begin
      showmessage('В ячейке отсутствует значение либо число введено не правильно');
      Exit;
     end;
    else
     begin
       MessageDlg('Возникла неизвестная исключительная ситуация! ',mtError,[mbCancel],0);
       Exit;
     end;
end;

end;
end.
