unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='2,444';
Edit2.Text:='0,869E-2';
Edit3.Text:='-0,13E3';
Memo1.Clear;
end;
procedure TForm1.Button1Click(Sender: TObject);
var x,y,z,a,b,c,h:extended;
begin
Memo1.Clear;
Memo1.Lines.Add('Исходные данные:');
X:=StrToFloat(Edit1.Text);
Memo1.Lines.Add('X:='+FloatToStrF(x,fffixed,8,4));
Y:=StrToFloat(Edit2.Text);
Memo1.Lines.Add('Y:='+FloatToStrF(y,fffixed,8,4));
Z:=StrToFloat(Edit3.Text);
Memo1.Lines.Add('Z:='+FloatToStrF(z,fffixed,8,4));
a:=(power(x,(y+1))+exp(y-1));
b:=1+x*abs(y-tan(z));
c:=abs(y-x);
h:=a/b*(1+c)+(sqr(c)/2)-(power(c,3)/3);
Memo1.Lines.Add('Результат h='+FloatToStrF(h,fffixed,8,5));


end;
end.
