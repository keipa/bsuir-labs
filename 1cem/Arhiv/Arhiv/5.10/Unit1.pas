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
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{
1.Перед просмотром кода программы настоятельно рекомендую изучить материал
по данной теме в методичке
2. В меню Tools->Debuger Options советую отключить опцию
"Stop on Delphi Exceptions" в закладке "Language Exceptions"
}

 Type TMas=array[1..1] of integer; //описываем вид используемого массива
 var
   Form1: TForm1;
   A,B:^TMas;     //создаем переменные типа "указатель", содержащих
                  //адрес первого байта памяти занимаемого массивом типа TMas
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
{в первую очередь предыдущие две строки служат для удобства: они занимают
нулевой столбец названием и мы дальше используем столбцы начиная с первого
номера, как и в обычном массиве}
  edit3.Text:='';   //очищаем поле ответа
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
//выделяем нужный для записи первого массива объем памяти
//в процедуре GetMem необходимо указать объем памяти в байтах, поэтому мы
//используем функцию SizeOf для определения кол-ва байт занимаемого тем или иным
//типом данных в памяти
 GetMem(a,n*sizeof(integer));
//аналогично для второго массива:
 GetMem(b,m*sizeof(integer));
//чтение данных из таблицы в массив
//(уделить внимаение и не перепутать столбцы и строки):
 for i:=1 to N do
  A^[i]:=StrToInt(StringGrid1.Cells[i,0]);
 for i:=1 to M do
  B^[i]:=StrToInt(StringGrid2.Cells[i,0]);

//переменная ex (от англ. exist-существует) содержит "0" если минимальное
//значение пока не определено или "1", если оно уже хоть раз найдено.
 ex:=0;
 for i:=1 to n do  //начало цикла перебора элементов первого массива
  begin
//каждый элемент первого массива сравниваем с каждым элементом второго массива
//присваеваем переменной k значение "1", если элемент первого массива
//встречается во втором массиве
   k:=0;
   for j:=1 to m do
    if a[i]=b[j] then k:=1;
//если совпадений для данного элемента первого массива не найдено и минимальное
//значение еще не было задано, задаем значение и изменяем переменную ex
   if (k=0) and (ex=0) then
    begin
     min:=a[i];
     ex:=1;
    end;
//если минимальное значение уже было однажды задано, но текущий элемент, меньше
//этого значения и подходит по условию, мы перезадаем минимальное значение
   if (k=0) and (ex=1) and (a[i]<min) then min:=a[i];
  end;             //конец цикла перебора элементов первого массива

//Вывод результата:
 if ex=0 then Edit3.Text:='Не найдено'
  else Edit3.Text:=inttostr(min);

//Освобождение памяти, занимаемой динамическим массивом
 freemem(a,n*sizeof(integer));
 freemem(b,m*sizeof(integer));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin  //кнопка-наворот, заполняющая таблицу первого массива случайными целыми
//числами в интервале от 0 до 99
 randomize;  //процедура инициализации функции задания случайного числа (random)
 for i:=1 to n do
   stringgrid1.Cells[i,0]:=inttostr(random(100));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin  //кнопка-наворот, заполняющая таблицу второго массива
 randomize;
 for i:=1 to m do
   stringgrid2.Cells[i,0]:=inttostr(random(100));
end;
{Копирайты на данную программу пренадлежат Майко Константину, студенту
группы 712502. Любое спользование кода этой учебной программы и самой программы
без ведома правообладателя будут преследоваться и караться вне закона.
Права на данное творение могут быть переданы другому лицу с устного разрешения
текущего правообладателя и за небольшое вознаграждение}
end.
{P.S. Крута я атжог да? гыгыгы
Если будут вопросы, предложения, просьбы по написанию других обучающих программ
звони +375297761673}
