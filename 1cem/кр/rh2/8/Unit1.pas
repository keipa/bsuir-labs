unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
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

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.Text := '0';
  Edit2.Text := '1';
  Edit3.Text := '100';
  Edit4.Text := '';
end;

function sx( x  : Extended ) : Extended;
begin
  sx := Sqr(sin(x));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a,b : Extended;
  n : LongInt;
  ans : Extended;
begin
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  n := StrToInt(Edit3.Text);
  ans := solve(a,b,n,sx);
  Edit4.Text := FloatToStrF(ans,ffFixed,8,3);
end;

end.
