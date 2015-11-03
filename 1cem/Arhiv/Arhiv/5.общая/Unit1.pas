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
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 const Nmax=10;
 Type mat=array [1..Nmax,1..Nmax] of extended;
      vek=array [1..Nmax] of extended;
var
   Form1: TForm1;
   A:mat;
   B,Y:vek;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   N:=3; M:=3;
   Edit1.Text:=inttostr(N);
   Edit2.Text:=inttostr(M);
   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=M+1;
   StringGrid2.RowCount:=m+1;
   StringGrid3.RowCount:=N+1;
   StringGrid1.Cells[0,0]:='  A';
   StringGrid2.Cells[0,0]:='  B';
   StringGrid3.Cells[0,0]:='  Y';

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
    StringGrid2.RowCount:=m+1;
    StringGrid3.RowCount:=N+1;
  for i:=1 to N do
     StringGrid1.Cells[0,i]:='  i='+IntToStr(i);
  for i:=1 to m do
     StringGrid1.Cells[i,0]:='  j='+IntToStr(i);
   end;

procedure TForm1.Button2Click(Sender: TObject);
   begin
     {$R+}
   try
for i:=1 to N do
  for j:=1 to m do
       A[i,j]:=StrToFloat(StringGrid1.Cells[j,i]);
for i:=1 to m do
       B[i]:=StrToFloat(StringGrid2.Cells[0,i]);
except
  on ERangeError do
     begin
     ShowMessage('Уменьшите размер массива');
     Exit;
     end;
  on EConvertError do
     begin
     ShowMessage('Проверьте значение числа');
     Exit;
     end;
        else
     begin
     ShowMessage('Возникла неизвестная исключительная ситуация!');
     Exit;
     end;
end;
try
for i:=1 to N do
     begin
     Y[i]:=0;
     for j:=1 to m do Y[i]:=Y[i]+A[i,j]*B[j];
     end;
except
  on EInvalidOp do
   begin
   MessageDlg('Неправильная операция с плавающей точкой',mtError,[mbCancel],0);
   Exit;
   end;
  on EOverFlow do
   MessageDlg('Переполнение при выполнении операции с плавающей точкой',mtError,
   [mbCancel],0);
 else begin
   MessageDlg('Возникла неизвестная исключительная ситуация!',mtError,
   [mbCancel],0);
   Exit;
   end;
end;
for i:=1 to N do
  StringGrid3.Cells[0,i]:=FloatToStrF(y[i],fffixed,6,0);
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
 randomize;
 for i:=1 to n do
  for j:=1 to m do
   stringgrid1.Cells[j,i]:=inttostr(random(10));
 for i:=1 to m do stringgrid2.Cells[0,i]:=inttostr(random(10));
end;

end.
