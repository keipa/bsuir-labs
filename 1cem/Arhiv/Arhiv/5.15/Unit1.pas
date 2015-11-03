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
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 var
   Form1: TForm1;
   A:array of integer;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
//размер массива по умолчанию в начале программы равен 5
  N:=5; Edit1.Text:=inttostr(N);
  StringGrid1.ColCount:=N;     //задаем кол-во столбцов таблицы
end;

procedure TForm1.Button1Click(Sender: TObject);
begin   //кнопка изменени€ размера массива
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N;
end;

procedure TForm1.Button3Click(Sender: TObject);
 var k,ex,min:integer;
begin
//выдел€ем нужный дл€ записи массива объем пам€ти
 SetLength(a,n+1);
//чтение данных из таблицы в массив
//(уделить внимаение и не перепутать столбцы и строки):
 for i:=1 to N do
  A[i]:=StrToInt(StringGrid1.Cells[i-1,0]);

 i:=1;      //задание начального значени€ счетчика
 repeat
  if a[i]<0 then  //проверка на отрицательность
   begin
    if i<>n then
     for j:=i+1 to n do a[j-1]:=a[j];
    dec(n); //уменьшение количества элементов массива
    dec(i);
   end;
  inc(i);
 until i>n; //проверка на выход за пределы масива

//пересоздадаим таблицу с нужным кол-вом €чеек:
 stringgrid1.ColCount:=n;
//¬ывод результата:
 for i:=1 to n do stringgrid1.cells[i-1,0]:=inttostr(a[i]);
//ќсвобождение пам€ти, занимаемой динамическим массивом
 a:=nil;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin  //кнопка-наворот, заполн€юща€ таблицу первого массива случайными целыми
//числами в интервале от -50 до 49
 randomize;  //процедура инициализации функции задани€ случайного числа (random)
 for i:=0 to n do
   stringgrid1.Cells[i,0]:=inttostr(random(100)-50);
end;

end.

