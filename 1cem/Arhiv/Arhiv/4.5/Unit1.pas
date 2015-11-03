unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, mxarrays;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Const
 Nmax=10;
Type
Mas2 = array[1..Nmax,1..Nmax] of extended ;

var
  Form1: TForm1;
  A : Mas2;
  w,k,M, N, i, j,kol : integer;



implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
N:=3; M:=3  ;

      Edit1.Text:=FloatToStr(N);
      Edit2.Text:=FloatToStr(M);

   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=M+1;


   StringGrid1.Cells[0,0]:='Массив A:';

   for i:=1 to N do begin
    StringGrid1.Cells[0,i]:=' i= '+IntToStr(i);
    For j:=1 to M do begin
    StringGrid1.Cells[j,0]:=' j= '+IntToStr(j);
                    end;


end;
 end;

procedure TForm1.Button2Click(Sender: TObject);
var w:extended ;
 begin
 {$R+}
     try

  for i:=1 to N do
   for j:=1 to M do
     A[i,j]:=StrToFloat(StringGrid1.Cells[j,i]);


     except
      on ERangeError do begin ShowMessage('Выход за пределы массива. Уменьшите размеры массива');
 Exit; end;
      on EConvertError do begin ShowMessage('В ячейке отсутствует значение, либо число введено не правильно');
 Exit; end;
      else begin ShowMessage('Возникла неизвестная исключительная ситуация');
 Exit; end;
    end;

     try
      kol:=0;
      for i:=1 to N do
      for j:=2 to M-1 do
  begin
w:=0;
for k:=1 to j-1 do
if a[i,k]>=a[i,j] then  begin  w:=1; break end;
for k:=j+1 to m do
 if a[i,k]<=a[i,j] then  begin w:=1; break end;
 if w=0 then inc(kol);
                   end;
   except
       on EInvalidOp do begin MessageDlg('Неправильная операция с плавающей точкой',mtError,[mbCancel],0);
            Exit; end;
        on EOverFlow do begin MessageDlg('Переполнение при выполне-нии операции с плавающей точкой',mtError,[mbCancel],0);
            Exit; end;
         else begin MessageDlg('Возникла неизвестная исключительная ситуация! ',mtError,[mbCancel],0);
            Exit; end;
       end;

Edit3.text:=intToStr(kol);
end;


procedure TForm1.Button1Click(Sender: TObject);
 begin
    N:=StrToInt(Edit1.Text);
    M:=StrToInt(Edit2.Text);
   StringGrid1.RowCount:=N+1;
   StringGrid1.ColCount:=M+1;

   for i:=1 to N do
   for j:=1 to M do
    StringGrid1.Cells[j,i]:=Floattostrf(a[i,1],fffixed,6,3);
end;


end.
 