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
    StringGrid2: TStringGrid;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
 w:extended;
  Form1: TForm1;
  A:Mas1;

  N,M,i,j,r,k,d:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 N:=4;
 M:=4;
 Edit1.Text:=IntToStr(N);
 Edit2.Text:=IntToStr(M);
 StringGrid1.RowCount:=N+1;
 StringGrid1.ColCount:=M+1;
 StringGrid2.RowCount:=N+1;
 StringGrid2.ColCount:=M+1;
 StringGrid1.Cells[0,0]:='Массив А';
 StringGrid2.Cells[0,0]:='Массив B';
 for i:=1 to N do
  begin
   StringGrid1.Cells[0,i]:='i='+IntToStr(i);
   StringGrid2.Cells[0,i]:='i='+IntToStr(i);
  end;
 for j:=1 to M do
  begin
   StringGrid1.Cells[j,0]:='j='+IntToStr(j);
   StringGrid2.Cells[j,0]:='j='+IntToStr(j);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 N:=StrToInt(Edit1.text);
 M:=StrToInt(Edit2.text);
 StringGrid2.RowCount:=N+1;
 StringGrid2.ColCount:=M+1;
 StringGrid1.RowCount:=N+1;
 StringGrid1.ColCount:=M+1;
 for i:=1 to N do
  begin
   StringGrid1.Cells[0,i]:='i='+IntToStr(i);
   StringGrid2.Cells[0,i]:='i='+IntToStr(i);
  end;
 for j:=1 to M do
  begin
   StringGrid1.Cells[j,0]:='j='+IntToStr(j);
   StringGrid2.Cells[j,0]:='j='+IntToStr(j);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
try
 for i:=1 to N do
  for j:=1 to M do
   A[i,j]:=StrToFloat(StringGrid1.Cells[j,i]);
except
 on ERangeError do
  begin
   ShowMessage('Выход за пределы массива. Уменьшите размеры массива');
   Exit;
  end;
 on EConvertError do
  begin
   ShowMessage('В ячейке отсутствует значение, либо число введено не правильно');
   Exit;
  end;
 else
  begin
   ShowMessage('Возникла неизвестная исключительная ситуация');
   Exit;
  end;
end;

try
 for k:=1 to n-1 do
  for i:=1 to n-k do
   if a[i,1] > a[i+1,1] then
  for j:=1 to m do
   begin
    w:=a[i,j];
    a[i,j]:=a[i+1,j];
    a[i+1,j]:=w;
   end;
except
 on EInvalidOp do
  begin
   MessageDlg('Неправильная операция с плавающей точкой',mtError,[mbCancel],0);
   Exit;
  end;
 on EOverFlow do
  begin
   MessageDlg('Переполнение при выполне-нии операции с плавающей точкой',mtError,[mbCancel],0);
   Exit;
  end;
 else
  begin
   MessageDlg('Возникла неизвестная исключительная ситуация! ',mtError,[mbCancel],0);
   Exit;
  end;
end;

 for i:=1 to N do
  for j:=1 to M do
   StringGrid2.Cells[j,i]:=FloatToStrf(A[i,j],fffixed,6,0);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 randomize;
 for i:=1 to n do
  for j:=1 to m do
   stringgrid1.Cells[j,i]:=inttostr(random(100));
end;

end.
