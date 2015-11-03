unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Math, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
Edit1.Text:='3,251';
Edit2.Text:='0,325';
Edit3.Text:='0,466e-4';
Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x,y,z,c:extended;
begin
  Memo1.Clear;
  Memo1.Lines.Add('Исходные данные:');
  x:=StrToFloat(Edit1.Text);
  Memo1.Lines.Add('X='+FloatToStrF(x,fffixed,8,3));
  y:=StrToFloat(Edit2.Text);
  Memo1.Lines.Add('Y='+FloatToStrF(y,fffixed,8,3));
  z:=StrToFloat(Edit3.Text);
  Memo1.Lines.Add('Z='+FloatToStrF(z,fffixed,8,7));
  c:=power(2,power(y,x))+power(power(3,x),y)-((y*(ArcTan(z)-Pi/6))/(abs(x)+(1/(power(y,2)+1))));
  Memo1.Lines.Add('Результат c ='+FloatToStrF(c,fffixed,8,3));
end;
end.
