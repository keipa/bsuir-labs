unit Unit1;

interface

uses StekProc, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

 type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Button5: TButton;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
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
    Procedure wrtspis;
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
  
var
  Form1: TForm1;
  mem,n,i:integer;
  w1,wk,t:TSeld;

implementation

{$R *.dfm}

Procedure TForm1.wrtspis;
begin
 if mem=1 then
  begin
   wrtbegD(w1,memo2);
   mem:=2;
   Memo1.Lines.add('(Было)');
  end
 else
  begin
   wrtbegD(w1,memo1);
   mem:=1;
   Memo2.Lines.add('(Было)');
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.text:='5';
 Edit2.text:='-50';
 Edit3.text:='50';
 Edit4.text:='';
 Edit5.Text:='';
 Edit6.Text:='';
 Memo1.clear;
 Memo2.Clear;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w1:=nil; wk:=nil;
 mem:=2;
 groupbox2.Enabled:=false;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delSpisD(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 mem:=2;
 n:=strtoint(edit1.Text);
 a:=strtoint(edit2.Text);
 b:=strtoint(edit3.Text);
 if n<1 then
  begin
   ShowMessage('Неправильное количество!');
   exit;
  end;
 if a>b then
  begin
   ShowMessage('Неправильный интервал!');
   exit;
  end;
 Randomize;
 delspisD(w1,wk);
 for i:=1 to n do AddEndD(w1,wk,Random(b-a+1)+a);
 wrtSpis;
 Memo2.Clear;
 groupbox2.Enabled:=true;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddBegD(w1,wk,strtoint(Edit4.Text));
 wrtSpis;
 Edit4.Clear;
 groupbox2.Enabled:=true;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:integer;
begin
 delBegD(w1,wk,a);
 wrtSpis;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 SortSlD(w1,wk);
 wrtSpis;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelSpisD(w1,wk);
 memo1.Clear;
 memo2.Clear;
 mem:=2;
 groupbox2.Enabled:=false;
 button3.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
 var max,min:integer;
begin
 t:=w1^.a;
 max:=w1^.inf;
 min:=w1^.inf;
 while t<>nil do
  begin
   if t^.inf>max then max:=t^.inf;
   if t^.inf<min then min:=t^.inf;
   t:=t^.a;
  end;
 t:=w1;
 while t<>nil do
  begin
   if t^.inf=max then t^.inf:=min else
    if t^.inf=min then t^.inf:=max;
   t:=t^.a;
  end;
 wrtSpis;
end;

procedure TForm1.Button8Click(Sender: TObject);
var a:integer;
    inf:Tinf;
    s:tseld;
begin
 if Edit5.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 a:=strtoint(Edit5.Text);
 t:=w1;
 while t<>nil do
  begin
   s:=t^.a;
   if t^.inf=a then DelD(w1,wk,t,inf);
   t:=s;
  end;
 wrtspis;
 Edit5.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddEndD(w1,wk,strtoint(Edit4.Text));
 wrtSpis;
 Edit4.Clear;
 groupbox2.Enabled:=true;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button9Click(Sender: TObject);
 var m:integer;
     a:TInf;
begin
 if Edit6.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
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
 wrtspis;
end;

procedure TForm1.Button10Click(Sender: TObject);
 var inf:TInf;
begin
 DelEndD(w1,wk,inf);
 wrtspis;
end;

end.
