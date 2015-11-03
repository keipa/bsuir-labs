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
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 Type TMas=array of integer; //описываем вид используемого массива
 var
   Form1: TForm1;
   A,B,c:TMas;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=5; Edit1.Text:=inttostr(N); //размер первого и второго массива
  M:=5; Edit2.Text:=inttostr(M); //по умолчанию в начале программы равен 5
  StringGrid1.ColCount:=N+1;     //задаем кол-во столбцов таблицы для первого
  StringGrid2.ColCount:=M+1;     //и второго массива
  StringGrid1.Cells[0,0]:='  A'; //называем таблицы
  StringGrid2.Cells[0,0]:='  B';
  StringGrid3.Cells[0,0]:='  C';
{в первую очередь предыдущие две строки служат для удобства: они занимают
нулевой столбец названием и мы дальше используем столбцы начиная с первого
номера, как и в обычном массиве}
  stringgrid3.Visible:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin   //кнопка изменения размера первого массива
//тут впринципе все тоже самое что и при создании формы, но только для
//первого массива
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N+1;
  StringGrid1.Cells[0,0]:='  A';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin   //кнопка изменения размера второго массива
  M:=StrToInt(Edit2.Text);
  StringGrid2.ColCount:=M+1;
  StringGrid2.Cells[0,0]:='  B';
end;

procedure TForm1.Button3Click(Sender: TObject);
 var k,ex,min:integer;
begin
 setlength(a,n+1);
 setlength(b,m+1);
 setlength(c,m+n+1);
 stringgrid3.Visible:=true;
 stringgrid3.ColCount:=n+m+1;
 for i:=1 to N do
  A[i]:=StrToInt(StringGrid1.Cells[i,0]);
 for i:=1 to M do
  B[i]:=StrToInt(StringGrid2.Cells[i,0]);

 i:=1; j:=1; k:=0;
 while (i<=n) and (j<=m) do
   if a[i]<b[j] then
    begin
     inc(k);
     c[k]:=a[i];
     inc(i);
    end
   else
    begin
     inc(k);
     c[k]:=b[j];
     inc(j);
    end;
 while i<=n do
  begin
   inc(k);
   c[k]:=a[i];
   inc(i);
  end;
 while j<=m do
  begin
   inc(k);
   c[k]:=b[j];
   inc(j);
  end;

 for i:=1 to k do
  stringgrid3.cells[i,0]:=inttostr(c[i]);
 a:=nil;
 b:=nil;
 c:=nil;
end;

end.

