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
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label6: TLabel;
    Label7: TLabel;
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

implementation

{$R *.dfm}

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
 n:=strtoint(edit1.Text);
 a:=strtoint(edit2.Text);
 b:=strtoint(edit3.Text);
 Randomize;
 delstek(w);
 for i:=1 to n do AddStek(w,Random(b-a+1)+a);
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
 button2.Enabled:=false;
 button4.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
 var m:integer;
     inf:tinf;
begin
 writestek(w,memo1);
 t:=w;
 while (t<>nil) and (t^.a<>nil) do
  begin
   delafterstek(t,inf);
   t:=t^.a;
  end;
 writestek(w,memo2);
end;

end.
