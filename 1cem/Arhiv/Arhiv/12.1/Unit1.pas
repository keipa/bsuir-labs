unit Unit1;

interface

uses StekProc, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
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
    Memo3: TMemo;
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

var
  Form1: TForm1;
  n,i:integer;
  o,g,w,t:Tsel;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.text:='10';
 Edit4.text:='';
 Edit5.text:='';
 Memo1.clear;
 Memo2.Clear;
 Memo3.Clear;
 button2.Enabled:=false;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w:=nil; o:=nil; g:=nil;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
 button3.Enabled:=true;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delStek(w);
 delstek(o);
 delstek(g);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 n:=strtoint(edit1.Text);
 a:=-50;
 b:=50;
 Randomize;
 delstek(w);
 delstek(o);
 delstek(g);
 for i:=1 to n do AddStek(w,Random(b-a+1)+a);
 writestek(w,memo1);
 button2.Enabled:=true;
 button4.Enabled:=true;
 memo2.Clear;
 memo3.clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 AddStek(w,strtoint(Edit4.Text));
 writestek(w,memo1);
 Edit4.Clear;
 button2.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var k,a:integer;
begin
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
 writestek(w,memo1);
 edit5.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 Case RadioGroup1.ItemIndex of
  0: SortAfter(w);
  1: SortInf(w);
 end;
 writestek(w,memo1);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelStek(w);
 delstek(o);
 delstek(g);
 memo1.Clear;
 memo2.Clear;
 memo3.Clear;
 button2.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
 var m:integer;
     inf:tinf;
     p,q:Tsel;
begin
 t:=w;
 q:=nil;
 p:=nil;
 while (t<>nil) do
  begin
   if t^.inf<0 then addstek(q,t^.inf) else addstek(p,t^.inf);
   t:=t^.a;
  end;
 o:=nil;
 g:=nil;
 t:=q;
 while t<>nil do
  begin
   addstek(o,t^.inf);
   t:=t^.a;
  end;
 t:=p;
 while t<>nil do
  begin
   addstek(g,t^.inf);
   t:=t^.a;
  end;
 writestek(o,memo2);
 writestek(g,memo3);
 delstek(p);
 delstek(q);
end;

end.
