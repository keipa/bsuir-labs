unit Unit1;

interface

uses StekProc, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

 type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label3: TLabel;
    Edit5: TEdit;
    Button8: TButton;
    Label5: TLabel;
    Edit6: TEdit;
    Button9: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Label8: TLabel;
    Memo4: TMemo;
    Button1: TButton;
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
  
var
  Form1: TForm1;
  mem,n,i:integer;
  o1,ok,g1,gk,w1,wk,t:TSel;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.text:='5';
 Edit4.text:='';
 Edit5.Text:='';
 Edit6.Text:='';
 Memo1.clear;
 Memo2.Clear;
 memo3.Clear;
 memo4.Clear;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w1:=nil; wk:=nil;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delSpis(w1,wk);
 delSpis(o1,ok);
 delSpis(g1,gk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 n:=strtoint(edit1.Text);
 Randomize;
 delspis(w1,wk);
 for i:=1 to n do AddEnd(w1,wk,(Random(101)-50));
 writespis(w1,wk,Memo1);
 Memo2.Clear;
 memo3.Clear;
 memo4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
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
 memo3.Clear;
 memo4.Clear;
 button3.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
 var inf:tinf;
begin
 t:=w1;
 o1:=nil; ok:=nil;
 g1:=nil; gk:=nil;
 while (t<>nil) do
  begin
   if t^.inf<0 then addend(o1,ok,t^.inf) else addend(g1,gk,t^.inf);
   t:=t^.a;
  end;
 writespis(o1,ok,memo3);
 writespis(g1,gk,memo4);
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
