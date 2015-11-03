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
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
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

function cR(n,m:integer):extended;
begin
 if n-m<1 then result:=1
 else result:=cR(n-1,m)*n*(n-m);
end;

function c(n,m:integer):extended;
var i:integer;
    c:extended;
begin
 c:=1;
 for i:=1 to n do
  begin
   c:=c*i;
   if i<=(n-m) then c:=c*i;
   if i<=m then c:=c/i;
  end;
 result:=c;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 label2.caption:='';
 label3.caption:='';
 edit1.Text:='';
 edit2.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var n,m,k:integer;
begin
 if (edit1.Text<>'') and (edit2.Text<>'') then
  begin
   n:=strtoint(edit1.Text);
   m:=strtoint(edit2.Text);
  end
 else
  begin
   showmessage('Введите все значения!');
   Exit;
  end;
 label2.Caption:='C='+floattostrf(cR(n,m),fffixed,8,0)+' (рекурсия)';
 label3.Caption:='C='+floattostrf(c(n,m),fffixed,8,0);
end;

end.
