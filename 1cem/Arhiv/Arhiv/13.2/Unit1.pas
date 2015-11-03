unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button2: TButton;
    Button3: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    Memo2: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Button5: TButton;
    memo1: TMemo;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   Type
  Tinf=integer;
  TSel=^Sel;
  Sel=record
      inf:Tinf;
      a:TSel;
   end;
   var
   w1,wk,q:TSel;inf:tinf; n:integer;
implementation

{$R *.dfm}

procedure AddBeg(var w1,wk:TSel; inf:Tinf);
     var t:TSel;
 begin
   if w1=nil then begin
                   new(w1);
                   w1^.inf:=inf;
                   w1^.a:=nil;
                   wk:=w1;
                   end
                else begin
                   new(t);
                   t^.inf:=inf;
                   t^.a:=w1;
                   w1:=t;
                   end;
 end;


procedure AddEnd(var w1,wk:TSel; inf:Tinf);
    var t:TSel;
 begin
   if wk=nil then begin

                  new(wk);
                  wk^.inf:=inf;
                  wk^.a:=nil;
                  w1:=wk;
                  end
             else begin
                  new(t);
                  t^.inf:=inf;
                  t^.a:=nil;
                  wk^.a:=t;
                  wk:=t;
                  end;
 end;


procedure AddAfter(sp:TSel; inf:Tinf);
     var t:TSel;
 begin
   if sp^.a=nil then exit;
   new(t);
   t^.inf:=inf;
   t^.a:=sp^.a;
   sp^.a:=t;
 end;



procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
    var t:tsel;
 begin
    if w1=nil then exit;
    inf:=w1^.inf;
    t:=w1;
    w1:=w1^.a;
    dispose(t);
    if w1=nil then wk:=nil;
 end;


procedure DelAfter(sp:TSel; var inf:Tinf);
    var t:tsel;
  begin
 if (sp^.a=nil) then exit;
 if sp^.a^.a=nil then
  begin
   sp^.a:=nil;
   wk:=sp;
   exit;
  end;
    t:=sp^.a;
    inf:=t^.inf;
    sp^.a:=t^.a;
    dispose(t);
  end;


procedure DelSpis(var w1,wk:TSel);
    var a:Tinf;
 begin
   while w1<>nil do DelBeg(w1,wk,a);
 end;


// ѕроцедура сортировки очереди сли€нием  двух отсортированных оче-
//редей SortSl() требует двух вспомогательных процедур:  сли€ни€ двух отсор-
//тированных очередей в одну ( отсортированную ) slip() и  разбиени€ очереди
//на две div1s():

procedure slip (var sq1,sqk,sr1,srk,sp1,spk:TSel);
     var  infq,infr:Tinf;
 begin
   sp1:=nil;   spk:=nil;
   while (sq1<>nil) and (sr1<>nil) do
      begin
      DelBeg(sq1,sqk,infq);
      DelBeg(sr1,srk,infr);
      if infq<infr then begin
                        AddEnd(sp1,spk,infq);
                        AddBeg(sr1,srk,infr);
                        end
                   else begin
                        AddEnd(sp1,spk,infr);
                        AddBeg(sq1,sqk,infq);
                        end;
      end;
   while sq1<>nil do
      begin
      DelBeg(sq1,sqk,infq);
      AddEnd(sp1,spk,infq);
      end;
   while sr1<>nil do
      begin
      DelBeg(sr1,srk,infr);
      AddEnd(sp1,spk,infr);

      end;
 end;

procedure div1s(var sp1,spk,sq1,sqk,sr1,srk:TSel);
    var inf:Tinf;
 begin
   sr1:=nil;  srk:=nil;
   sq1:=nil;  sqk:=nil;
   while sp1<>nil do
      begin
      DelBeg(sp1,spk,inf);
      AddEnd(sq1,sqk,inf);
      if sp1<>nil then begin
                       DelBeg(sp1,spk,inf);
                       AddEnd(sr1,srk,inf);
                       end;
      end;
 end;

procedure SortSl(var w1,wk:TSel);
    var sq1,sr1,sqk,srk:TSel;
 begin
   if w1<>wk then
      begin
      div1s(w1,wk,sq1,sqk,sr1,srk);
      sortsl(sq1,sqk);
      sortsl(sr1,srk);
      slip(sq1,sqk,sr1,srk,w1,wk);
      end;
 end;


procedure WrtBegD(w1:Tsel; s:TMemo);
   var t:Tsel;
begin
   t:=w1;   s.clear;
   while  t<>nil  do
      begin
      s.lines.add(IntToStr(t^.inf));
      t:=t^.a;
      end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Edit2.Clear;
  Memo1.Clear;
  Memo2.Clear;
end;


procedure TForm1.Button2Click(Sender: TObject);
var k,kol:integer;  z,t,p:tsel;
begin
WrtBegD(w1,memo1);
if w1=nil then exit;
 while (w1<>nil) and (not odd(w1.inf)) do DelBeg(w1,wk,inf);
if w1=nil then exit;
t:=w1;
while t^.a<>nil do if not odd(t^.a^.inf) then Delafter(t,inf) else t:=t^.a;
WrtBegD(w1,Memo2);
end;

procedure TForm1.Button3Click(Sender: TObject);
var t:tsel;k:integer;
begin
WrtBegD(w1,memo1);
  if Edit2.text='' then  inf:=-10+Random(21)
   else
       inf:=strToint(Edit2.text);

case RadioGroup1.ItemIndex of
        0: AddEnd(w1,wk,inf);
        1: AddBeg(w1,wk,inf);
              end;
  WrtBegD(w1,Memo2);
end;

procedure TForm1.Button4Click(Sender: TObject);
var k:integer;t:tsel;
begin
 WrtBegD(w1,memo1);
 SortSl( w1,wk);
 WrtBegD(w1,Memo2);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
      DelSpis(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var t,p:tsel;
begin
 WrtBegD(w1,memo1);
 if w1=nil then exit;
 if Edit1.text='' then
     begin
     showmessage('¬ведите удал€емый элемент');
     exit;
     end;
  while (w1<>nil) and (w1^.inf=strtoint(edit1.Text)) do delbeg(w1,wk,inf);
  if w1=nil then exit;
  t:=w1;
  while t^.a<>nil do
   if t^.a^.inf=strtoint(Edit1.Text) then DelAfter(t,inf) else t:=t^.a;
 WrtBegD(w1,Memo2);
 Edit1.clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     memo1.Clear;    memo2.Clear;
     DelSpis(w1,wk);

end;

procedure TForm1.Button6Click(Sender: TObject);
var i:byte;
begin
 delspis(w1,wk);
 Memo2.clear;
 for i:=1 to 10 do AddEnd(w1,wk,-10+random(21));
  WrtBegD(w1,Memo1);
end;

end.

