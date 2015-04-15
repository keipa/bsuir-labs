unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;

    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   a: array [1..1000] of integer;

implementation

{$R *.dfm}

Function Maxel(l,r:integer):integer;
var b,c:integer;
begin
if l=r
  then Maxel:=a[l]
else
begin
  b:=Maxel(l,(l+r)div 2);
  c:=Maxel(((l+r)div 2)+1, r);
  Maxel:=max(a[b],a[c]);
end;
end;
procedure TForm1.Button1Click(Sender: TObject);
var n,i,it:integer;


begin
n:=strtoint(edit1.text);

randomize;

memo1.Clear;
for I:=1 to n do
a[i]:=random(15);
for I:=1 to n do
memo1.lines.add(inttostr(a[i]));
it:=maxel(0,n);
memo1.lines.add(inttostr(it));
end;

end.
