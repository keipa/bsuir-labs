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
    StringGrid2: TStringGrid;
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
   A,B:array of integer;
   N,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=5; Edit1.Text:=inttostr(N);
  StringGrid1.ColCount:=N+1;
  StringGrid2.ColCount:=N+1;
  StringGrid1.Cells[0,0]:='  A'; //называем таблицы
  StringGrid2.Cells[0,0]:='  T';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N+1;
  StringGrid2.ColCount:=N+1;
  StringGrid1.Cells[0,0]:='  A';
  StringGrid2.Cells[0,0]:='  T';
end;

procedure TForm1.Button3Click(Sender: TObject);
 var t:integer;
begin
//выделяем нужный для записи первого массива объем памяти
 SetLength(a,n+1);
//чтение данных из таблицы в массив
 for i:=1 to N do
  A[i]:=StrToInt(StringGrid1.Cells[i,0]);

 for i:=1 to (n div 2) do
  begin
   t:=a[i];
   a[i]:=a[n-i+1];
   a[n-i+1]:=t;
  end;

//Вывод результата:
 for i:=1 to n do
  Stringgrid2.Cells[i,0]:=inttostr(a[i]);
//Освобождение памяти, занимаемой динамическим массивом
 a:=nil;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 randomize;
 for i:=1 to n do
   stringgrid1.Cells[i,0]:=inttostr(random(100));
end;

end.

