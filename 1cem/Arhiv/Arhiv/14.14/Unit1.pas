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
    Button10: TButton;
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
 delSpisD(w1,wk);
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
 delspisd(w1,wk);
 for i:=1 to n do AddEndD(w1,wk,Random(b-a+1)+a);
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
end;

procedure TForm1.Button4Click(Sender: TObject);
 var m:integer;
     inf:tinf;
     s:tseld;
begin
 WrtBegD(w1,memo1);
 m:=0;
 if w1=nil then exit;
 t:=w1^.a;
 while t<>nil do
  begin
   s:=t^.a;
   deld(w1,wk,t,inf);
   if s<>nil then t:=s^.a else break;
  end;
 WrtBegD(w1,memo2);
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
