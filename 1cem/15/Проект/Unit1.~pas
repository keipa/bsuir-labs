unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit2;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox3: TListBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Stack:TStack;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;
begin
  Button2.Enabled:=True; Button4.Enabled:=True;
  Button3.Enabled:=True; Button5.Enabled:=True;
  Randomize;
  p:=nil;
  ListBox1.Clear;
  for i:=1 to n do
    begin
      j:=random(20)+1;
      Stack.Add(p,j);
      ListBox1.Items.Add(IntToStr(j));
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  k:word;
begin
  Button1.Enabled:=True;
  Button2.Enabled:=False;
  Button3.Enabled:=False;
  Button4.Enabled:=False;
  Button5.Enabled:=False;
  ListBox1.Clear;
  Stack.Sort(p);
  while p<>nil do
    begin
      Stack.From(p,k);
      ListBox1.Items.Add(IntToStr(k));
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var k:word;
begin
  p1:=nil;
  p2:=nil;
  ListBox2.Clear;
  ListBox3.Clear;
  Stack.Even(p,p1,p2);
  while p1<>nil do
    begin
      Stack.From(p1,k);
      ListBox3.Items.Add(IntToStr(k));
    end;
  while p2<>nil do
    begin
      Stack.From(p2,k);
      ListBox2.Items.Add(IntToStr(k));
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button1.Enabled:=True;
  Button2.Enabled:=False;
  Button3.Enabled:=False;
  Button4.Enabled:=False;
  Button5.Enabled:=False;
  n:=10;
end;

procedure TForm1.Button4Click(Sender: TObject);
var j:word;
begin
  n:=n+1;
  j:=random(20)+1;
  Stack.Add(p,j);
  ListBox1.Items.Add(IntToStr(j));
end;

procedure TForm1.Button5Click(Sender: TObject);
var k:word;
begin
  n:=n-1;
  Stack.From(p,k);
  ListBox1.Items.Delete(k);
end;

end.
