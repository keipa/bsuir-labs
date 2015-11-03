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
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Button4: TButton;
    StringGrid2: TStringGrid;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 Type TMas=array of integer;
 var
   Form1: TForm1;
   A,B:TMas;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=5; Edit1.Text:=inttostr(N); //размер массива
  StringGrid1.ColCount:=N+1;     //задаем кол-во столбцов таблицы
  StringGrid2.ColCount:=N+1;
  stringGrid1.Cells[0,0]:='  A'; //называем таблицы
  StringGrid2.Cells[0,0]:='  B';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin   //кнопка изменения размера массива
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N+1;
  StringGrid2.ColCount:=N+1;
  StringGrid1.Cells[0,0]:='  A';
  StringGrid2.Cells[0,0]:='  B';
end;

procedure TForm1.Button3Click(Sender: TObject);
 var t:integer;
begin
//выделяем нужный для записи массива объем памяти
 SetLength(a,n+1);
//чтение данных из таблицы в массив
//(уделить внимаение и не перепутать столбцы и строки):
 for i:=1 to N do
  A[i]:=StrToInt(StringGrid1.Cells[i,0]);

 m:=0;
 for i:=1 to n do
  if a[i]<0 then
   begin
    j:=i;
    while j>m+1 do
     begin
      t:=a[j];
      a[j]:=a[j-1];
      a[j-1]:=t;
      dec(j);
     end;
    inc(m);
   end;

//Вывод результата:
 for i:=1 to n do stringgrid2.Cells[i,0]:=inttostr(a[i]);

//Освобождение памяти, занимаемой динамическим массивом
 a:=nil;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 randomize;
 for i:=1 to n do
   stringgrid1.Cells[i,0]:=inttostr(random(101)-50);
end;

end.

