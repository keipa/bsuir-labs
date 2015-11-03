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
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 delSpis(w1,wk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
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
 writespis(w1,wk,Memo1);
 Memo2.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 writespis(w1,wk,Memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
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
end;

procedure TForm1.Button4Click(Sender: TObject);
 var inf:tinf;
begin
 writespis(w1,wk,Memo1);
 t:=w1;
 while (t<>nil) and (t^.a<>nil) do
  begin
   delafterspis(w1,wk,t,inf);
   t:=t^.a;
  end;
 writespis(w1,wk,Memo2);
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
   ShowMessage('Введите значение!');
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
