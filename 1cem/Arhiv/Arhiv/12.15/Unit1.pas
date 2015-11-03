unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
type Tinf=integer;
     Tsel=^Sel;
     Sel=record
         inf:Tinf;
         a:Tsel;
         end;

var
  Form1: TForm1;
var w,t,sp:Tsel;
    n,c,d,e:integer;

implementation

  Procedure Revinf(sp:TSel);
     var inf:Tinf;
      begin
      inf:=sp^.inf;
      sp^.inf:=sp^.a^.inf;
       sp^.a^.inf:=inf;
      end;

procedure Sortinf(w:TSel);
  var p,t:Tsel;
   begin
     if (w=nil)or(w^.a=nil) then exit;
    t:=nil;
     repeat
     p:=w;
     while p^.a<>t do
      begin
        if p^.inf>p^.a^.inf then Revinf(p);
        p:=p^.a;
      end;
      t:=p;
     until w^.a=t;
   end;

procedure DelLast(var w:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w=nil then exit;
 inf:=w^.inf;
 t:=w;
 w:=w^.a;
 dec(n);
 dispose(t);
end;

Procedure WrtStek(w:TSel; Memo:TMemo);
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

function ReadStek(w:TSel; n:integer):Tinf;
 var inf:Tinf;
     i:integer;
     t:TSel;
begin
 if w=nil then exit;
 t:=w;
 for i:=1 to n do
  begin
   inf:=t^.inf;
   t:=t^.a;
  end;
 result:=inf;
end;

procedure WrtZnach(w:TSel; n:integer; inf:Tinf);
 var i:integer;
     t:TSel;
begin
 if w=nil then exit;
 t:=w;
 for i:=1 to n-1 do t:=t^.a;
 t^.inf:=inf;
end;

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
Memo1.Clear;  Memo2.Clear;
randomize;
w:=nil; n:=0;
Edit1.Text:='-5';
Edit2.Text:='5';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   c:=strtoint(Edit1.text);
   d:=strtoint(edit2.Text);
   New(t);
   t^.inf:=random(d-c+1)-d;
   t^.a:=w;
   w:=t;
   inc(n);
   wrtstek(w,memo1);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 memo1.Clear;
 sortinf(w);
 t:=w;
 WrtStek(w,Memo1);
end;

procedure TForm1.Button3Click(Sender: TObject);
var a:integer;
begin
 dellast(w,a);
 wrtStek(w,memo1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var inf:Tinf;
    i:integer;
begin
 if w^.a=nil then
  begin
   wrtstek(w,memo2);
   exit;
  end;
 for i:=1 to (n div 2) do
  begin
   inf:=readstek(w,i);
   wrtznach(w,i,readstek(w,n-i+1));
   wrtznach(w,n-i+1,inf);
  end;
 wrtstek(w,Memo2);
end;

end.
