unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Label3: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Tinf=integer;
  Tsel=^sel;
  sel=record
  inf:Tinf;
  a:Tsel;
  end;
var
  Form1: TForm1;
  n,r:integer;
  w,t:Tsel;

implementation

{$R *.dfm}

procedure dellast(var w:TSel; var inf:Tinf);
var t:TSel;
begin
if w=nil then exit;
inf:=w^.inf;
t:=w;
w:=w^.a;
dispose(t);
end;

Procedure Revinf(sp:TSel);
var inf:Tinf;
begin
inf:=sp^.inf;
sp^.inf:=sp^.a^.inf;
sp^.a^.inf:=inf;
end;

procedure SortInf(w:TSel);
 var p,t:TSel;
begin
 if (w=nil) or (w.a=nil) then exit;
 t:=nil;
 repeat
  p:=w;
  while p^.a<>t do
   begin
    if p^.inf>p^.a^.inf then revInf(p);
    p:=p^.a;
   end;
  t:=p;
 until w^.a=t;
end;

procedure delstek(var w:Tsel);
var inf:Tinf;
begin
While w<>nil do dellast(w,inf);
end;

procedure WrtStek(w:Tsel; LS:TMemo);
var t:Tsel;
begin
LS.clear;
t:=w;
while t<>nil do
begin
LS.Lines.Add(intToStr(t^.inf));
t:=t^.a;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.clear;
button1.Enabled:=false;
button3.Enabled:=false;
Label4.Caption:='';
w:=nil; r:=0;
Edit1.Text:='';
Edit2.Text:='';
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var i:integer;
begin
if key=#13 then
begin
 n:=Strtoint(Edit1.Text);
 Edit1.Clear;
 r:=n;
 delstek(w);
 memo1.clear;
 w:=nil; randomize;
 for i:=1 to n do
  begin
  new(t);
  t^.inf:=random(11)-5;
  t^.a:=w;
  w:=t;
  Memo1.Lines.Add(Inttostr(t^.inf));
  end;
 if n>=2 then begin
  button1.Enabled:=true;
  button3.Enabled:=true; end;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
inc(r);
if r>=2 then begin
button1.Enabled:=true;
button3.Enabled:=true; end;
{if Edit2.Text='' then
 begin
  ShowMessage('¬ведите значение!!!'); exit;
 end;}
new(t);
t^.inf:=strtoint(Edit2.Text);
t^.a:=w;
w:=t;
memo1.Lines.Add(Edit2.Text);
Edit2.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
memo1.Clear;
SortInf(w);
wrtstek(w,memo1);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 DelStek(w);
 Memo1.Clear;
 Label4.Caption:='';
 r:=0;
 button1.Enabled:=false;
 button3.Enabled:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
 var max,min,i,maxI,minI:integer;
begin
t:=w^.a; max:=w^.inf; min:=w^.inf;
maxI:=1; minI:=1;
for i:=2 to n do
 begin
 if t^.inf>max then
  begin
   max:=t^.inf;
   maxI:=i;
  end;
 if t^.inf<min then
  begin
   min:=t^.inf;
   minI:=i;
  end;
 t:=t^.a;
 end;
 if maxi=mini then label4.Caption:='0';
 label4.Caption:=inttostr(abs(maxI-minI-1));
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delstek(w);
end;

end.
