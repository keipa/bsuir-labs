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
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 const Nmax=100;
 Type mat=array [1..Nmax,0..Nmax] of extended;
var
   Form1: TForm1;
   A:mat;
   k,N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=3; Edit1.Text:=inttostr(N);
  M:=3; Edit2.Text:=inttostr(M);
   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=M+1;
   StringGrid1.Cells[0,0]:='  A';
   edit3.Text:='';
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
    StringGrid1.Cells[0,i]:='  i= '+IntToStr(i);
   for i:=1 to M do
    StringGrid1.Cells[i,0]:='  j= '+IntToStr(i);
   end;

procedure TForm1.Button2Click(Sender: TObject);
   begin
     {$R+}
   try
for i:=1 to N do
  for j:=1 to N do
       A[i,j]:=StrToFloat(StringGrid1.Cells[j,i]);
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

for i:=1 to n do a[i,0]:=0; {стимрание старых данных}
k:=0;

for i:=1 to N do           {подсчет суммы элементов I-тогой строки}
 for j:=1 to m do a[i,0]:=a[i,0]+a[i,j];

for i:=1 to n do           {подсчет "особых" элементов}
 for j:=1 to m do
  if a[i,j]>a[i,0]-a[i,j] then inc(k);

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
edit3.Text:=inttostr(k);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
randomize;
for i:=1 to n do
 for j:=1 to m do
  stringGrid1.Cells[i,j]:=inttostr(random(10));
end;

end.
