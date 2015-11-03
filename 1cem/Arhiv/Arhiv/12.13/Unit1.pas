unit Unit1;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

 type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Button5: TButton;
    Edit5: TEdit;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    Button6: TButton;
    Memo2: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  n,i,max,maxi:integer;
  w,t:Tsel;
  b:array[1..10] of integer;

implementation

{$R *.dfm}

Procedure AddStek(var w:TSel; inf:TInf);
 var t:TSel;
begin
 New(t);
 t^.inf:=inf;
 t^.a:=w;
 w:=t;
end;

Procedure DelLast(var w:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w=nil then exit;
 inf:=w^.inf;
 t:=w;
 w:=w^.a;
 dispose(t);
end;

Procedure DelAfterStek(sp:TSel; var inf:Tinf);
 var t:TSel;
begin
 if (sp^.a=nil) then exit;
 if sp^.a^.a=nil then
  begin
   sp^.a:=nil;
   exit;
  end;
 t:=sp^.a;
 inf:=t^.inf;
 sp^.a:=t^.a;
 dispose(t);
end;

Procedure DelStek(var w:TSel);
 var inf:Tinf;
begin
 while w<>nil do DelLast(w,inf);
end;

Procedure RevAfter(sp:TSel);
 var t:TSel;
begin
 t:=sp^.a^.a;
 sp^.a^.a:=t^.a;
 t^.a:=sp^.a;
 sp^.a:=t;
end;

Procedure RevInf(sp:TSel);
 var inf:Tinf;
begin
 inf:=sp^.inf;
 sp^.inf:=sp^.a.inf;
 sp^.a^.inf:=inf;
end;

Procedure SortAfter(var w:TSel);
 var p,t:TSel;
     inf:Tinf;
begin
 if (w=nil) or (w.a=nil) then exit;
 AddStek(w,0);
 t:=nil;
 repeat
  p:=w;
  while p^.a^.a<>t do
   begin
    if p^.a^.inf>p^.a^.a^.inf then RevAfter(p);
    p:=p^.a;
   end;
  t:=p^.a;
 until w^.a^.a=t;
 DelLast(w,inf);
end;

Procedure SortInf(w:TSel);
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

Procedure WriteStek(w:TSel; Memo:TMemo);
 var t:Tsel;
begin
 Memo.clear;
 t:=w;
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
 Edit5.text:='';
 Memo1.clear;
 Memo2.Clear;
 button2.Enabled:=false;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w:=nil;
 label5.Caption:='';
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
 button3.Enabled:=true;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delStek(w);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 n:=strtoint(edit1.Text);
 Randomize;
 delstek(w);
 for i:=1 to n do AddStek(w,Random(10)+1);
 writestek(w,memo1);
 button2.Enabled:=true;
 button4.Enabled:=true;
 memo2.Clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 writestek(w,memo1);
 AddStek(w,strtoint(Edit4.Text));
 writestek(w,memo2);
 Edit4.Clear;
 button2.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var k,a:integer;
begin
 writestek(w,memo1);
 k:=strtoint(edit5.Text);
 if k=1 then
  begin
   dellast(w,a);
   writestek(w,memo2);
   edit5.Clear;
   exit;
  end;
 t:=w;
 i:=1;
 while (i<k-1) and (t<>nil) do
  begin
   t:=t^.a;
   inc(i);
  end;
 if (t=nil) or (t^.a=nil) then
  begin
   ShowMessage('Неправильное значение!');
   exit;
  end;
 if t^.a^.a=nil then t^.a:=nil else t^.a:=t^.a^.a;
 writestek(w,memo2);
 edit5.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 writestek(w,memo1);
 Case RadioGroup1.ItemIndex of
  0: SortAfter(w);
  1: SortInf(w);
 end;
 writestek(w,memo2);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelStek(w);
 memo1.Clear;
 memo2.Clear;
 label5.Caption:='';
 button2.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 fillchar(b,sizeof(b),0);
 t:=w;
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
 label5.caption:='Частовстречающееся: '+inttostr(maxi);
end;

end.
