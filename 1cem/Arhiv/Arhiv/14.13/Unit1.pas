unit Unit1;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

 type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Edit4: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Button5: TButton;
    Memo1: TMemo;
    Button6: TButton;
    Button7: TButton;
    Memo2: TMemo;
    Label3: TLabel;
    Edit5: TEdit;
    Button8: TButton;
    Label5: TLabel;
    Edit6: TEdit;
    Button9: TButton;
    Button10: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Tinf=integer;
  TSeld=^Seld;
  Seld=record
   inf:Tinf;
   a,b:TSeld;
  end;

var
  Form1: TForm1;
  mem,n,i:integer;
  w1,wk,t:TSeld;

implementation

{$R *.dfm}

Procedure AddBegD(var w1,wk:Tseld; inf:Tinf);
 var t:Tseld;
begin 
 New(t);
 t^.inf:=inf;
 t^.b:=nil;
 if w1=nil then
  begin
   t^.a:=nil;
   w1:=t;
   wk:=t;
  end
 else
  begin
   t^.a:=w1;
   w1^.b:=t;
   w1:=t;
  end;
end;

Procedure AddEndD(var w1,wk:Tseld; inf:Tinf);
 var t:Tseld;
begin
 New(t);
 t^.inf:=inf;
 t^.a:=nil;
 if wk=nil then
  begin
   t^.b:=nil;
   w1:=t;
   wk:=t;
  end
 else
  begin
   t^.b:=wk;
   wk^.a:=t;
   wk:=t;
  end;
end;

Procedure AddAfterD(sp:Tseld; inf:Tinf);
 var t:Tseld;
begin
 if (sp=nil) or (sp^.a=nil) then exit;
 New(t);
 t^.inf:=inf;
 t^.a:=sp^.a;
 t^.b:=sp;
 sp^.a:=t;
 t^.a^.b:=t;
end;

Procedure AddBefD(sp:Tseld; inf:Tinf);
 var t:Tseld;
begin
 if (sp=nil) or (sp^.b=nil) then exit;
 New(t);
 t^.inf:=inf;
 t^.a:=sp;
 t^.b:=sp^.b;
 sp^.b^.a:=t;
 sp^.b:=t;
end;

Procedure DelBegD(var w1,wk:Tseld; var inf:Tinf);
 var t:Tseld;
begin
 if w1=nil then exit;
 inf:=w1^.inf;
 t:=w1;
 if w1=wk then
  begin
   w1:=nil;
   wk:=nil;
  end
 else
  begin
   w1^.a^.b:=nil;
   w1:=w1^.a;
  end;
 Dispose(t);
end;

Procedure DelEndD(var w1,wk:Tseld; var inf:Tinf);
 var t:Tseld;
begin
 if wk=nil then exit;
 inf:=wk^.inf;
 t:=wk;
 if w1=wk then
  begin
   w1:=nil;
   wk:=nil;
  end
 else
  begin
   wk^.b^.a:=nil;
   wk:=wk^.b;
  end;
 Dispose(t);
end;

Procedure DelD(var w1,wk,sp:Tseld; var inf:Tinf);
begin
 if sp=nil then exit;
 if sp^.a=nil then
  begin
   delendD(w1,wk,inf);
   exit;
  end;
 if sp^.b=nil then
  begin
   DelBegD(w1,wk,inf);
   exit;
  end;
 inf:=sp^.inf;
 sp^.b^.a:=sp^.a;
 sp^.a^.b:=sp^.b;
 Dispose(sp);
end;

Procedure DelSpisD(var w1,wk:Tseld);
 var inf:Tinf;
begin
 while w1<>nil do DelBegD(w1,wk,inf);
end;

Procedure WrtBegD(w1:Tseld; s:TMemo);
 var t:Tseld;
begin
 t:=w1;
 s.clear;
 while t<>nil  do
  begin
   s.lines.add(IntToStr(t^.inf));
   t:=t^.a;
  end;
end;

Procedure WrtEndD(wk:Tseld; s:TMemo);
 var t:Tseld;
begin
 t:=wk;
 s.clear;
 while  t<>nil  do
  begin
   s.lines.add(IntToStr(t^.inf));
   t:=t^.b;
  end;
end;

Procedure slipD (var sq1,sqk,sr1,srk,sp1,spk:TSeld);
 var  infq,infr:Tinf;
begin
 sp1:=nil;   spk:=nil;
 while (sq1<>nil) and (sr1<>nil) do
  begin
   DelBegD(sq1,sqk,infq);
   DelBegD(sr1,srk,infr);
   if infq<infr then
    begin
     AddEndD(sp1,spk,infq);
     AddBegD(sr1,srk,infr);
    end
   else
    begin
     AddEndD(sp1,spk,infr);
     AddBegD(sq1,sqk,infq);
    end;
  end;
 while sq1<>nil do
  begin
   DelBegD(sq1,sqk,infq);
   AddEndD(sp1,spk,infq);
  end;
 while sr1<>nil do
  begin
   DelBegD(sr1,srk,infr);
   AddEndD(sp1,spk,infr);
  end;
end;

Procedure div2s(var sp1,spk,sq1,sqk,sr1,srk:TSeld);
 var inf:Tinf;
begin
 sr1:=nil;  srk:=nil;
 sq1:=nil;  sqk:=nil;
 while sp1<>nil do
  begin
   DelBegD(sp1,spk,inf);
   AddEndD(sq1,sqk,inf);
   if sp1<>nil then
    begin
     DelBegD(sp1,spk,inf);
     AddEndD(sr1,srk,inf);
    end;
  end;
end;

Procedure sortslD(var w1,wk:TSeld);
 var sq1,sr1,sqk,srk:TSeld;
begin
 if w1<>wk then
  begin
   div2s(w1,wk,sq1,sqk,sr1,srk);
   sortslD(sq1,sqk);
   sortslD(sr1,srk);
   slipD(sq1,sqk,sr1,srk,w1,wk);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.text:='10';
 Edit4.text:='';
 Edit5.Text:='';
 Edit6.Text:='';
 Memo1.clear;
 Memo2.Clear;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w1:=nil; wk:=nil;
 label2.Caption:='';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delSpisD(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 n:=strtoint(edit1.Text);
 Randomize;
 delspisd(w1,wk);
 for i:=1 to n do AddEndD(w1,wk,Random(10)+1);
 WrtBegD(w1,memo1);
 Memo2.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 WrtBegD(w1,memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddBegD(w1,wk,strtoint(Edit4.Text));
 WrtBegD(w1,memo2);
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:integer;
begin
 WrtBegD(w1,memo1);
 delBegD(w1,wk,a);
 WrtBegD(w1,memo2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 WrtBegD(w1,memo1);
 SortSlD(w1,wk);
 WrtBegD(w1,memo2);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelSpisD(w1,wk);
 memo1.Clear;
 memo2.Clear;
 button3.Enabled:=false;
 button4.Enabled:=false;
 label2.Caption:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
var max,maxi:integer;
 b:array[1..10] of integer;
begin
 fillchar(b,sizeof(b),0);
 t:=w1;
 while t<>nil do
  begin
   inc(b[t^.inf]);
   t:=t^.a;
  end;
 max:=b[1];
 maxi:=1;
 for i:=2 to 10 do
  if b[i]>max then
   begin
    max:=b[i];
    maxi:=i;
   end;
 label2.caption:='Частовстречающееся: '+inttostr(maxi);
end;

procedure TForm1.Button8Click(Sender: TObject);
var a:integer;
    inf:Tinf;
    s:TSeld;
begin
 WrtBegD(w1,memo1);
 a:=strtoint(Edit5.Text);
 t:=w1;
 while t<>nil do
  begin
   s:=t^.a;
   if t^.inf=a then DelD(w1,wk,t,inf);
   t:=s;
  end;
 WrtBegD(w1,memo2);
 Edit5.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 WrtBegD(w1,memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddEndD(w1,wk,strtoint(Edit4.Text));
 WrtBegD(w1,memo2);
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button9Click(Sender: TObject);
 var m:integer;
     a:TInf;
begin
 WrtBegD(w1,memo1);
 m:=strtoint(edit6.Text);
 Edit6.Clear;
 t:=w1;
 for i:=1 to m-1 do
  begin
   t:=t^.a;
   if t=nil then
    begin
     showmessage('Неправильное значение!');
     exit;
    end;
  end;
 delD(w1,wk,t,a);
 WrtBegD(w1,memo2);
 Edit6.Clear;
end;

procedure TForm1.Button10Click(Sender: TObject);
var inf:Tinf;
begin
 WrtBegD(w1,memo1);
 DelEndD(w1,wk,inf);
 WrtBegD(w1,memo2);
end;

end.
