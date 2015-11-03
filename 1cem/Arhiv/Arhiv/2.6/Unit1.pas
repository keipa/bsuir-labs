unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
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
Edit1.Text:='0,1';
Edit2.Text:='0,356';
Memo1.Clear;
RadioGroup1.ItemIndex:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
x,b,g,f,n:extended;
begin
  x:=strToFloat(Edit1.text);
  Memo1.Lines.Add('x='+Edit1.text);
  b:=strToFloat(Edit2.text);
  Memo1.Lines.Add('b='+Edit2.text);
  case RadioGroup1.ItemIndex of
    0: f:=sinh(x);
    1: f:=sqr(x);
    2: f:=exp(x);
  end;
  n:=abs(b);
  if ( 0.5<x*b) and (x*b<10) then
     g:=exp(f-n)
     else
       if ( 0.1<x*b) and (x*b<0.5) then
         g:=sqrt(abs(f+b))
         else
           g:=2*sqr(f);
  Memo1.Lines.Add('g='+FloatToStrF(g,ffFixed,8,2)) ;
  Memo1.Lines.Add('____________________');
end;
end.
