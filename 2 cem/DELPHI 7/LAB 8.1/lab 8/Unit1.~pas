unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, unit2;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    TreeView1: TTreeView;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit2: TEdit;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tr:Ttree; btr:tbtr; n:integer; b:boolean;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
n:=9; Edit1.Text:=IntToStr(n);
Memo1.Clear; Edit2.Clear;
  With StringGrid1 do begin
Cells[0,0]:='Фамилия'; 			Cells[1,0]:='Номер';
Cells[0,1]:='Капаницкая'; Cells[1,1]:='258487';
Cells[0,2]:='Чужба';	 Cells[1,2]:='251548';
Cells[0,3]:='Жукова'; Cells[1,3]:='254598';
Cells[0,4]:='Васильев'; Cells[1,4]:='251677';
Cells[0,5]:='Смирнов';  Cells[1,5]:='257899';
Cells[0,6]:='Мишин'; Cells[1,6]:='256374';
Cells[0,7]:='Лин';	Cells[1,7]:='256749';
Cells[0,8]:='Катаевская'; Cells[1,8]:='258596';
Cells[0,9]:='Рубанова';	Cells[1,9]:='259431';
  end;
  tr:=Ttree.create;
end;

procedure TForm1.Button1Click(Sender: TObject);//изменяет размер
begin
  n:=StrToInt(Edit1.Text);   StringGrid1.RowCount:=N+1;
end;

procedure TForm1.Button2Click(Sender: TObject);//вводит дерево
Var i:integer; a:TMs;
 begin
 StringGrid1.RowCount:=n+2;
    For i:=1 to n do
       With  A[i] do begin
           s:=StringGrid1.Cells[0,i];
           key:=StrToInt(StringGrid1.Cells[1,i]);
            end;
       tr.Make1B(a,n); tr.View; b:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);//прямой обход
begin
    Memo1.Clear; Tr.WrtB;
end;

procedure TForm1.Button4Click(Sender: TObject);//удаляет дерево
begin
   tr.free; Memo1.Clear; TreeView1.Items.Clear;
end;

procedure TForm1.Button5Click(Sender: TObject); //сбалансирование
var i,j:integer; a:TMs; t:TInf;
begin
  for i:=1 to N do
    with a[i] do
      begin
        s:=StringGrid1.Cells[0,i];
        key:=StrToInt(StringGrid1.Cells[1,i]);
      end;
  for i:=1 to N-1 do
    for j:=i+1 to N do
      if a[i].key>a[j].key then
        begin
          t:=a[i];
          a[i]:=a[j];
          a[j]:=t;
        end;
  Memo1.Clear; TreeView1.Items.Clear;
  with tr do begin
      if b then
        Delete(proot);
      BLns(a,N);
      View;
      WrtB;
  end;
  b:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);//поиск по ключу
var q:Tkey; inf:tinf;
begin
  q:=StrToInt(Edit2.Text); inf:=tr.Poisk(q); Memo1.Clear;
If inf.key=nok then Memo1.Lines.Add('По заданному ключу ничего не найдено')
               else Memo1.Lines.Add(inf.s+' '+IntToStr(inf.key));
end;

procedure TForm1.Button7Click(Sender: TObject); //удаление по ключу
var q:Tkey;
begin
 q:=StrToInt(Edit2.Text);tr.delk(q); Memo1.Clear; tr.View; tr.WrtB;
end;

procedure TForm1.Button8Click(Sender: TObject);//симметричный
begin
  Memo1.Clear; Tr.Wrt2;
end;

procedure TForm1.Button9Click(Sender: TObject);//добавляет запись
Var a:Tinf;
begin
  inc(n); StringGrid1.RowCount:=n+2; a.S:=StringGrid1.Cells[0,n];
  a.key:=StrToInt(StringGrid1.Cells[1,n]); tr.addb(a); tr.View;
end;

procedure TForm1.Button10Click(Sender: TObject); //считает количество символов
begin
  Memo1.Clear; btr.simvol; tr.View;
end;
end.
