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
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
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
  N:=3; Edit1.Text:=inttostr(N);
   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=N+1;
   StringGrid1.Cells[0,0]:='  A';
   edit2.Text:='';
   edit3.Text:='';

  for i:=1 to N do
     begin
     StringGrid1.Cells[0,i]:='  i='+IntToStr(i);
     StringGrid1.Cells[i,0]:='  j='+IntToStr(i);
     end;
    end;

procedure TForm1.Button1Click(Sender: TObject);
  begin
    N:=StrToInt(Edit1.Text);
    StringGrid1.RowCount:=N+1;
    StringGrid1.ColCount:=N+1;
   for i:=1 to N do
    begin
    StringGrid1.Cells[0,i]:='  i='+IntToStr(i);
    StringGrid1.Cells[i,0]:='  j='+IntToStr(i);
    end;
   end;

procedure TForm1.Button2Click(Sender: TObject);
var min,max:extended;
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
max:=a[1,n];
for i:=2 to n do
 for j:=n-i+1 to n do if a[i,j]>max then max:=a[i,j];
min:=a[1,n];
for i:=1 to n do
 for j:=i to n do if a[i,j]<min then min:=a[i,j];
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
edit2.Text:=floattostrf(max,fffixed,8,0);
edit3.Text:=floattostrf(min,fffixed,8,0);
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
 randomize;
 for i:=1 to n do
  for j:=1 to n do
   stringgrid1.Cells[i,j]:=inttostr(random(10));
end;

end.
