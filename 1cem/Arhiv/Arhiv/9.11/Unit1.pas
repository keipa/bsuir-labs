unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Math, TeeProcs, TeEngine,
  Chart, ClipBrd, Series, biblio;

type
  kord=array[1..4] of integer;
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Label9: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit12: TEdit;
    Label12: TLabel;
    Button2: TButton;
    BitBtn2: TBitBtn;
    function masshtab:extended;
    procedure KordCh;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  x:kord;
  y:kord;
  k:array[1..6] of extended;
  p:array[1..3] of boolean;
  i,j:integer;

implementation

{$R *.dfm}

function max1(a:kord):integer;
begin
 result:=a[1];
 for i:=2 to 4 do if a[i]>result then result:=a[i];
end;

function min1(a:kord):integer;
begin
 result:=a[1];
 for i:=2 to 4 do if a[i]<result then result:=a[i];
end;

function TForm1.masshtab:extended;
var a,b:extended;
begin
 a:=(2*image1.Height)/(3*(max1(y)-min1(y)));
 b:=(2*image1.Width)/(3*(max1(x)-min1(x)));
 result:=min(a,b);
end;

procedure TForm1.KordCh;
var m:extended;
 a,b:integer;
begin
 m:=masshtab;
 a:=min1(x);
 b:=min1(y);
 for i:=1 to 4 do
  begin
   x[i]:=round((x[i]-a)*m+image1.Width/6);
   y[i]:=round(image1.height*(5/6)-(y[i]-b)*m);
  end;
end;

function dlina:boolean;
var d:array[1..6] of extended;
begin
 d[1]:=sqrt(sqr(x[1]-x[2])+sqr(y[1]-y[2]));
 d[4]:=sqrt(sqr(x[1]-x[4])+sqr(y[1]-y[4]));
 d[2]:=sqrt(sqr(x[2]-x[3])+sqr(y[2]-y[3]));
 d[3]:=sqrt(sqr(x[3]-x[4])+sqr(y[3]-y[4]));
 if (d[1]=d[2]) and (d[1]=d[3]) and (d[1]=d[4]) then
  result:=true else result:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.Text:='1';
 Edit2.Text:='1';
 Edit3.Text:='2';
 Edit4.Text:='3';
 Edit5.Text:='4';
 Edit6.Text:='4';
 Edit7.Text:='5';
 Edit8.Text:='2';
 Edit9.Text:='0,2';
 Edit10.Text:='1';
 Edit11.Text:='10';
 Edit12.Text:='0,001';
 Label9.Caption:='';
 Image1.Canvas.Pen.Color:=clred;
 Image1.Canvas.Pen.width:=3;
end;

procedure TForm1.Button1Click(Sender: TObject);
var t:integer;
begin
 image1.Canvas.FillRect(image1.ClientRect);
 x[1]:=strtoint(Edit1.Text);
 y[1]:=strtoint(Edit2.Text);
 x[2]:=strtoint(Edit3.Text);
 y[2]:=strtoint(Edit4.Text);
 x[3]:=strtoint(Edit5.Text);
 y[3]:=strtoint(Edit6.Text);
 x[4]:=strtoint(Edit7.Text);
 y[4]:=strtoint(Edit8.Text);
 if x[1]=x[2] then k[1]:=1E-8 else
  k[1]:=(y[1]-y[2])/(x[1]-x[2]);
 if x[1]=x[4] then k[4]:=1E-8 else
  k[4]:=(y[1]-y[4])/(x[1]-x[4]);
 if x[3]=x[2] then k[2]:=1E-8 else
  k[2]:=(y[2]-y[3])/(x[2]-x[3]);
 if x[3]=x[4] then k[3]:=1E-8 else
  k[3]:=(y[3]-y[4])/(x[3]-x[4]);

 if (k[1]<>k[3]) and (k[2]<>k[4]) then
   Label9.Caption:='Четырехугольник';

 if ((k[1]=k[3]) and (k[2]<>k[4])) or ((k[1]<>k[3]) and (k[2]=k[4])) then
   Label9.Caption:='Трапеция';

 if (k[1]=k[3]) and (k[2]=k[4]) then
  begin
   if not dlina then
    Label9.Caption:='Трапеция'
   else
    if (k[2]=0) and (k[1]=1e-8) then
     Label9.Caption:='Квадрат'
    else
     if k[1]=-1/k[2] then
      Label9.Caption:='Квадрат'
     else
      Label9.Caption:='Ромб';
  end;
 KordCh;
 Image1.Canvas.Polygon([point(x[1],y[1]),point(x[2],y[2]),point(x[3],y[3]),point(x[4],y[4])]);
end;

procedure TForm1.Button2Click(Sender: TObject);
var M,a,b,h,ax,s,eps:extended;
begin
 series1.Clear;
 series2.Clear;
 a:=StrToFloat(Edit9.text);
 b:=StrToFloat(Edit10.text);
 M:=StrToFloat(Edit11.text);
 eps:=StrToFloat(Edit12.text);
 h:=(b-a)/m;
 ax:=a;
 repeat
  sum(ax,eps,s);
  series1.AddXY(ax,s,'',clred);
  series2.AddXY(ax,yf(ax),'',clgreen);
  ax:=ax+h;
 until ax>b+1e-9; 
end;

end.
