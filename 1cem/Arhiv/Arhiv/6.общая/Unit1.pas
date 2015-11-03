unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, biblio;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
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
edit1.Text:='0';
edit2.Text:='1';
edit3.Text:='0,1';
edit4.Text:='0,0001';
memo1.clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b,h,x,s,eps:extended;
    it:word;
begin
a:=StrToFloat(Edit1.text);
b:=StrToFloat(Edit2.text);
h:=StrToFloat(Edit3.text);
eps:=StrToFloat(Edit4.text);
x:=a;
 repeat
  sum(x,eps,s,it);
  memo1.Lines.Add(floattostrf(x,fffixed,5,2)+
          '     '+floattostrf(s,fffixed,9,6)+
          '     '+floattostrf(y(x),fffixed,9,6)+
          '     '+inttostr(it));
  x:=x+h;
 until x>b+0.0000000001;
end;

end.
