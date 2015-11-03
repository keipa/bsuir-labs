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
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  
var
  Form1: TForm1;
  mem,n,i:integer;
  w1,wk,t:TSel;

implementation

{$R *.dfm}

Procedure TForm1.wrtspis;
begin
 if mem=1 then
  begin
   writespis(w1,wk,memo2);
   mem:=2;
   Memo1.Lines.add('(Было)');
  end
 else
  begin
   writespis(w1,wk,memo1);
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
 Groupbox2.Enabled:=false;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delSpis(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 mem:=2;
 Groupbox2.Enabled:=true;
 n:=strtoint(edit1.Text);
 a:=strtoint(edit2.Text);
 b:=strtoint(edit3.Text);
 if a>b then
  begin
   ShowMessage('Неправильный интервал!');
   exit;
  end;
 Randomize;
 delspis(w1,wk);
 for i:=1 to n do AddEnd(w1,wk,Random(b-a+1)+a);
 wrtSpis;
 Memo2.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Groupbox2.Enabled:=true;
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddBeg(w1,wk,strtoint(Edit4.Text));
 wrtSpis;
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:integer;
begin
 delBeg(w1,wk,a);
 wrtSpis;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 SortSl(w1,wk);
 wrtSpis;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelSpis(w1,wk);
 memo1.Clear;
 memo2.Clear;
 mem:=2;
 Groupbox2.Enabled:=false;
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
begin
 if w1=nil then exit;
 if Edit5.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 a:=strtoint(Edit5.Text);
 while (w1<>nil) and (w1^.inf=a) do delbeg(w1,wk,inf);
 if w1=nil then exit;
 t:=w1;
 while t^.a<>nil do
  if t^.a^.inf=a then DelAfterSpis(w1,wk,t,inf) else t:=t^.a;
 wrtspis;
 Edit5.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 Groupbox2.Enabled:=true;
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddEnd(w1,wk,strtoint(Edit4.Text));
 wrtSpis;
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button9Click(Sender: TObject);
 var m:integer;
     a:TInf;
begin
 m:=strtoint(edit6.Text);
 if m=1 then delbeg(w1,wk,a) else
  begin
   t:=w1;
   for i:=1 to m-2 do
    begin
     t:=t^.a;
     if t=nil then
      begin
       showmessage('Неправильное значение!');
       exit;
      end;
    end;
   if t^.a=nil then
    begin
     showmessage('Неправильное значение!');
     exit;
    end;
   delafterSpis(w1,wk,t,a);
  end;
 wrtspis;
 Edit6.Clear;
end;

end.
