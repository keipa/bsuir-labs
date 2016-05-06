unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    image2: TImage;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  m,n : LongInt;
  a,b : Extended;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  image2.Picture := nil;
  Edit2.Text := '2';
  Edit1.Text := '1';
  Edit3.Text := '10';
  edit4.Text := '10';
end;

function sx( x : Extended ) : Extended;
var
  i : LongInt;
  q,ans : Extended;
begin
  ans := 1;
  q := 1;
  for i := 1 to m do begin
    q := q*x/i;
    ans := ans + q;
  end;
  sx := ans;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  n := StrToInt(Edit3.Text);
  m := StrToInt(Edit4.text);
  Draw(a,b,n,sx,image2);
end;

end.
