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
    Label3: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Button5: TButton;
    Edit5: TEdit;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    RadioGroup1: TRadioGroup;
    Button6: TButton;
    Memo2: TMemo;
    Procedure wrtstek;
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
  w,t:Tsel;
  mem:byte;

implementation

{$R *.dfm}

Procedure TForm1.wrtstek;
begin
 if mem=1 then
  begin
   writestek(w,memo2);
   mem:=2;
   Memo1.Lines.add('(Было)');
  end
 else
  begin
   writestek(w,memo1);
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
 Edit5.text:='';
 Memo1.clear;
 Memo2.Clear;
 button2.Enabled:=false;
 button3.Enabled:=false;
 button4.Enabled:=false;
 w:=nil;
 mem:=2;
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
var a,b:integer;
begin
 mem:=2;
 n:=strtoint(edit1.Text);
 a:=strtoint(edit2.Text);
 b:=strtoint(edit3.Text);
 if a>b then
  begin
   ShowMessage('Неправильный интервал!');
   exit;
  end;
 Randomize;
 delstek(w);
 for i:=1 to n do AddStek(w,Random(b-a+1)+a);
 wrtStek;
 button2.Enabled:=true;
 button4.Enabled:=true;
 memo2.Clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 if Edit4.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 AddStek(w,strtoint(Edit4.Text));
 wrtstek;
 Edit4.Clear;
 button2.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var k,a:integer;
begin
 if Edit5.Text='' then
  begin
   ShowMessage('Введите значение!');
   exit;
  end;
 k:=strtoint(edit5.Text);
 if k=1 then
  begin
   dellast(w,a);
   wrtstek;
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
 wrtstek;
 edit5.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 Case RadioGroup1.ItemIndex of
  0: SortAfter(w);
  1: SortInf(w);
 end;
 wrtstek;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 DelStek(w);
 memo1.Clear;
 memo2.Clear;
 mem:=2;
 button2.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
 var max,min:integer;
begin
 t:=w^.a;
 max:=w^.inf;
 min:=w^.inf;
 while t<>nil do
  begin
   if t^.inf>max then max:=t^.inf;
   if t^.inf<min then min:=t^.inf;
   t:=t^.a;
  end;
 t:=w;
 while t<>nil do
  begin
   if t^.inf=max then t^.inf:=min else
    if t^.inf=min then t^.inf:=max;
   t:=t^.a;
  end;
 wrtstek;
end;

end.
