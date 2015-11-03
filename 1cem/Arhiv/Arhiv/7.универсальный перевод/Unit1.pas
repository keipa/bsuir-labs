unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,m:integer;

implementation

{$R *.dfm}

function st(k,z:integer):extended; //функци€ возведени€ в степень
var i:integer;                     //k-число, z-степень
    g:extended;
begin
 result:=k;
 if z>0 then
  for i:=1 to z do result:=result*n;
 if z<0 then
  begin
   g:=1;
   for i:=1 to abs(z) do g:=g*n;
   result:=k*(1/g);
  end;
end;

function ConvIn(s:char):integer;  //функци€ перевода из символа в число
var x:integer;
begin
 case ord(s) of
  48..57: convin:=strtoint(s);
  65..90: convin:=ord(s)-55;
  97..122: convin:=ord(s)-87;
 end;
end;

function ConvOut(k:integer):char; //функци€ перевода из числа в символ
begin
 case k of
  0..9 : convout:=inttostr(k)[1];
  10..36 : convout:=chr(k+55);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.Text:='';
 Edit2.Text:='';
 Edit3.Text:='';
 Edit4.Text:='';
 Edit4.Visible:=false;        //скрытие пол€ результата
end;

procedure TForm1.Button1Click(Sender: TObject);
var r,h,g,x,z,i,j: integer;
a,b:string;
k,c:extended;
l:boolean;
begin
//защита от дурака
 if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='')
  or (strtoint(Edit1.Text)>36) or (strtoint(Edit3.Text)>36) then
  begin
   Showmessage('ѕроверьте значени€');
   Exit;
  end;
//задание значений
 n:=strtoint(Edit1.text);
 m:=strtoint(Edit3.text);
 a:=Edit2.Text;
 c:=0; b:=''; x:=0;
 l:=false;
 if a[1]='-' then        //проверка на отрицательность
  begin
   l:=true;
   delete(a,1,1);
  end;
 if pos('.',a)<>0 then   //защита от дурака (замена точки на зап€тую)
  begin
   z:=pos('.',a);
   a[z]:=',';
  end;
 z:=pos(',',a);          //определение требуемой точности вычислений
 if z<>0 then
  x:=strtoint(InputBox('¬ведите целое значение','¬ведите требуемое кол-во знаков после зап€той',inttostr(length(a)-z)));
 if x>0 then             //разветвление на целые и нецелые числа
  begin
//перевод целой части в дес€тиричную систему
   for i:=1 to z-1 do
    c:=c+st(convin(a[i]),z-i-1);
//перевод дробной части в дес€тиричную
   for i:=z+1 to length(a) do
    c:=c+st(convin(a[i]),z-i);
//перевод целой части в нужную систему
   g:=trunc(c);
   repeat
    h:=g mod m;
    g:=g div m;
    b:=convout(h)+b;
   until g<m;
   b:=convout(g)+b;
//перевод дробной части в нужную систему
   k:=frac(c);
   b:=b+',';
   for i:=1 to x do
    begin
     k:=k*m;
     h:=trunc(k);
     k:=frac(k);
     b:=b+convout(h);
    end;
  end
 else
  begin
//перевод целого числа в дес€тичную систему
   r:=length(a);
   if (z<>0) and (z<r) then r:=z;
   for i:=1 to r do
    c:=c+st(convin(a[i]),r-i);
//перевод целого числа из дес€тичной в нужную систему
   g:=trunc(c);
   repeat
    h:=g mod m;
    g:=g div m;
    b:=convout(h)+b;
   until g<m;
   b:=convout(g)+b;
  end;
 if l then b:='-'+b;       //определение знака
 edit4.Visible:=true;      //видимость пол€ ответа
 edit4.Text:=b;            //вывод ответа
end;
{јвтор: ћайко  ост€, ст.гр.712502, ICQ:211268307
 ƒата: 15 окт€бр€ 2007 года}
end.
