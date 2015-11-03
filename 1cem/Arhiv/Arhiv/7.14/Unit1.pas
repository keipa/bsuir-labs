unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 ComboBox1.Text:='';
 Memo1.Clear;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 ComboBox1.SetFocus;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
   ComboBox1.Items.Add(ComboBox1.Text);
   ComboBox1.Text:='';
  end;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
var s,sr:string;
      n,k,w,i,j:integer;
      a:array[1..100] of string;
begin
   memo1.clear;
   S:=ComboBox1.Text;
   sr:=s;
   S:=S+' ';
   repeat          //формирование строки удобной для разбивания на слова
    k:=Pos('  ',s);
    if k<>0 then Delete (s,k,1);
   until k=0;
   if S[1]=' ' then delete(s,1,1);

   n:=0;          //формирование массива слов
   repeat
    k:=pos(' ',s);
    if k<>0 then
     begin
      inc(n);
      a[n]:=copy(s,1,k-1);
      delete(s,1,k);
     end;
    until k=0;

    w:=length(a[1]);     //поиск наибольшей длинны
    for i:=1 to n do
     if length(a[i])>w then w:=length(a[i]);
    Memo1.Lines.add('Длина слова: '+inttostr(w));
    Memo1.Lines.add('Список слов: ');

    for i:=1 to n do    //поиск и вывод всех слов наибольшей длинны
     begin
      if length(a[i])=w then
       begin
        Memo1.Lines.Add(a[i]);
        Memo1.Lines.add('Номер слова: '+inttostr(i));
        Memo1.Lines.add('Начальная позиция: '+inttostr(pos(a[i],sr)));
        delete(sr,pos(a[i],sr),w);   //замена слова с максимальной длинной на пробелы
        for j:=1 to w do sr:=' '+sr; //чтобы не было проблем с одинаковыми словами
       end;
     end;
end;

end.
