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
  o1,ok,g1,gk,w1,wk,t:TSeld;

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
 delSpisd(w1,wk);
 delSpisd(o1,ok);
 delSpisd(g1,gk);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b:integer;
begin
 n:=strtoint(edit1.Text);
 Randomize;
 delspisd(w1,wk);
 for i:=1 to n do AddEndd(w1,wk,(Random(101)-50));
 wrtbegd(w1,Memo1);
 Memo2.Clear;
 memo3.Clear;
 memo4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 wrtbegd(w1,Memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddBegd(w1,wk,strtoint(Edit4.Text));
 wrtbegd(w1,Memo2);
 Edit4.Clear;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var a:integer;
begin
 wrtbegd(w1,Memo1);
 delBegd(w1,wk,a);
 wrtbegd(w1,Memo2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 wrtbegd(w1,Memo1);
 SortSld(w1,wk);
 wrtbegd(w1,Memo2);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelSpisd(w1,wk);
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
   if t^.inf<0 then addendd(o1,ok,t^.inf) else addendd(g1,gk,t^.inf);
   t:=t^.a;
  end;
 wrtbegd(o1,memo3);
 wrtbegd(g1,memo4);
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
 wrtbegd(w1,Memo1);
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddEndd(w1,wk,strtoint(Edit4.Text));
 wrtbegd(w1,Memo1);
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

end.
