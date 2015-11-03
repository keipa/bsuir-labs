unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
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
memo1.Clear;
edit1.text:='0,1';
edit2.text:='1';
edit3.text:='10';
edit4.text:='0,01';
edit5.text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var M,a,b,h,x,w,s,eps:extended;
    k:integer;
begin
 a:=strtofloat(edit1.Text);
 b:=strtofloat(edit2.Text);
 M:=strtofloat(edit3.Text);
 eps:=strtofloat(edit4.Text);
 x:=a; h:=(b-a)/M;
 edit5.Text:=floattostrf(h,fffixed,6,2);
 repeat
       s:=1;   w:=1;  k:=0;
       repeat
             inc(k);
             w:=-w*sqr(x)/(2*k*(2*k-1));
             s:=s+w;
       until abs(w)<eps;
       memo1.Lines.Add(floattostrf(x,fffixed,5,2)+
         '    '+floattostrf(s,fffixed,9,6)+
         '    '+floattostrf(cos(x),fffixed,9,6)+
         '    '+inttostr(k));
       x:=x+h;
 until x>b+1e-9;
end;

end.
