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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Tinf=integer;
  TSel=^sel;
  Sel=record
   inf:Tinf;
   a:Tsel;
  end;
    
var
  Form1: TForm1;
  mem,n,i:integer;
  w1,wk,t:TSel;

implementation

{$R *.dfm}

Procedure AddBeg(var w1,wk:TSel; inf:Tinf);
 var t:TSel;
begin
 if w1=nil then
  begin
   new(w1);
   w1^.inf:=inf;
   w1^.a:=nil;
   wk:=w1;
  end
 else
  begin
   new(t);
   t^.inf:=inf;
   t^.a:=w1;
   w1:=t;
  end;
end;

Procedure AddEnd(var w1,wk:TSel; inf:Tinf);
 var t:TSel;
begin
 if wk=nil then
  begin
   new(wk);
   wk^.inf:=inf;
   wk^.a:=nil;
   w1:=wk;
  end
 else
  begin
   new(t);
   t^.inf:=inf;
   t^.a:=nil;
   wk^.a:=t;
   wk:=t;
  end;
end;

Procedure AddAfter(sp:TSel; inf:Tinf);
 var t:TSel;
begin
 if sp^.a=nil then exit;
 new(t);
 t^.inf:=inf;
 t^.a:=sp^.a;
 sp^.a:=t;
end;

Procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w1=nil then exit;
 inf:=w1^.inf;
 t:=w1;
 w1:=w1^.a;
 dispose(t);
 if w1=nil then wk:=nil;
end;

Procedure DelAfterSpis(var w1,wk,sp:TSel; var inf:Tinf);
 var t:TSel;
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

Procedure DelSpis(var w1,wk:TSel);
 var a:Tinf;
begin
 while w1<>nil do DelBeg(w1,wk,a);
end;

Procedure slip(var sq1,sqk,sr1,srk,sp1,spk:TSel);
 var infq,infr:Tinf;
begin
 sp1:=nil; spk:=nil;
 while (sq1<>nil) and (sr1<>nil) do
  begin
   DelBeg(sq1,sqk,infq);
   DelBeg(sr1,srk,infr);
   if infq<infr then
    begin
     AddEnd(sp1,spk,infq);
     AddBeg(sr1,srk,infr);
    end
   else
    begin
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

Procedure div1s(var sp1,spk,sq1,sqk,sr1,srk:TSel);
 var inf:Tinf;
begin
 sr1:=nil; srk:=nil;
 sq1:=nil; sqk:=nil;
 while sp1<>nil do
  begin
   delbeg(sp1,spk,inf);
   AddEnd(sq1,sqk,inf);
   if sp1<>nil then
    begin
     DelBeg(sp1,spk,inf);
     AddEnd(sr1,srk,inf);
    end;
  end;
end;

Procedure SortSl(var w1,wk:TSel);
 var sq1,sqk,sr1,srk:TSel;
begin
 if w1<>wk then
  begin
   div1s(w1,wk,sq1,sqk,sr1,srk);
   sortsl(sq1,sqk);
   sortsl(sr1,srk);
   slip(sq1,sqk,sr1,srk,w1,wk);
  end;
end;

Procedure WriteSpis(w1,wk:TSel; Memo:TMemo);
 var t:Tsel;
begin
 Memo.clear;
 t:=w1;
 while t<>nil do
  begin
   Memo.lines.add(inttostr(t^.inf));
   t:=t^.a;
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
 delSpis(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 n:=strtoint(edit1.Text);
 Randomize;
 delspis(w1,wk);
 for i:=1 to n do AddEnd(w1,wk,Random(10)+1);
 writespis(w1,wk,Memo1);
 Memo2.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
 label2.Caption:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 writespis(w1,wk,Memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('¬ведите значение!');
   exit;
  end;
 AddBeg(w1,wk,strtoint(Edit4.Text));
 writespis(w1,wk,Memo2);
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:integer;
begin
 writespis(w1,wk,Memo1);
 delBeg(w1,wk,a);
 writespis(w1,wk,Memo2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 writespis(w1,wk,Memo1);
 SortSl(w1,wk);
 writespis(w1,wk,Memo2);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelSpis(w1,wk);
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
 label2.caption:='„астовстречающеес€: '+inttostr(maxi);

end;

procedure TForm1.Button8Click(Sender: TObject);
var a:integer;
    inf:Tinf;
begin
 writespis(w1,wk,Memo1);
 if w1=nil then exit;
 a:=strtoint(Edit5.Text);
 while (w1<>nil) and (w1^.inf=a) do delbeg(w1,wk,inf);
 if w1=nil then exit;
 t:=w1;
 while t^.a<>nil do
  if t^.a^.inf=a then DelAfterSpis(w1,wk,t,inf) else t:=t^.a;
 writespis(w1,wk,Memo2);
 Edit5.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 writespis(w1,wk,Memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('¬ведите значение!');
   exit;
  end;
 AddEnd(w1,wk,strtoint(Edit4.Text));
 writespis(w1,wk,Memo2);
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button9Click(Sender: TObject);
 var m:integer;
     a:TInf;
begin
 writespis(w1,wk,Memo1);
 m:=strtoint(edit6.Text);
 if m=1 then delbeg(w1,wk,a) else
  begin
   t:=w1;
   for i:=1 to m-2 do t:=t^.a;
   delafterSpis(w1,wk,t,a);
  end;
 writespis(w1,wk,Memo2);
 Edit6.Clear;
end;

end.
