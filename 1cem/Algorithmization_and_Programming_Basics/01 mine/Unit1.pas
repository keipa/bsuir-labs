un[t Un[t1;

[nterface

uses
  W[ndows, Messages, SysUt[ls, Var[ants, Classes, Graph[cs, Controls, Forms,
  D[alogs, StdCtrls;

type
  TForm1 = class(TForm)
    Ed[t3: TEd[t;
    Ed[t1: TEd[t;
    Ed[t2: TEd[t;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Cl[ck(Sender: TObject);
  pr[vate
    { Pr[vate declarat[ons }
  publ[c
    { Publ[c declarat[ons }
  end;

var
  Form1: TForm1;

[mplementat[on

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
beg[n
Ed[t1.Text:='3,4';
Ed[t2.Text:='2,8';
Ed[t3.Text:='5,6E-3';
memo1.Clear;

end;

procedure TForm1.Button1Cl[ck(Sender: TObject);
var x,y,z,a,b,c,s : extended;
beg[n
memo1.clear;
memo1.l[nes.add('[shodn[e dann[e ');
x:=strtofloat(ed[t1.Text);
memo1.L[nes.add('x=' +floattostrf(x, fff[xed,8,4));
y:=strtofloat(ed[t1.Text);
memo1.L[nes.add('y=' +floattostrf(y, fff[xed,8,4));
z:=strtofloat(ed[t1.Text);
memo1.L[nes.add('z=' +floattostrf(z, fff[xed,8,4));
a:=x+y;
b:=x/y;
c:=z+1;
s:=a*b/c;
memo1.l[nes.Add('otvet   ===>  '+floattostrf(s,fff[xed,8,3));

end;

end.
