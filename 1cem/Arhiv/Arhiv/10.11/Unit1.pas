unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Edit2: TEdit;
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

function yR(n:integer):extended;
begin
 if n=1 then result:=1/(1+1/2) else
  result:=1/(n+yR(n-1));
end;

function y(n:integer):extended;
var i:integer;
    y:extended;
begin
 y:=1/2;
 for i:=1 to n do
  y:=1/(i+y);
 result:=y; 
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 label2.caption:='';
 label3.caption:='';
 edit1.Text:='';
 edit2.Text:='4';
end;

procedure TForm1.Button1Click(Sender: TObject);
var n,k:integer;
begin
 if (edit1.Text<>'') and (edit2.Text<>'') then
  begin
   n:=strtoint(edit1.Text);
   k:=strtoint(edit2.Text);
  end
 else
  begin
   showmessage('Введите все значения!');
   Exit;
  end;
 label2.Caption:='y(n)='+floattostrf(yr(n),fffixed,20,k)+' (рекурсия)';
 label3.Caption:='y(n)='+floattostrf(y(n),fffixed,20,k);
end;

end.
