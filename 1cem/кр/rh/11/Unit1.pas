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
    Memo1: TMemo;
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
  a,b : Extended;
  n,m : LongInt;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  memo1.clear;
  edit1.Text := '1';
  Edit2.Text := '2';
  edit3.Text := '10';
  Edit4.Text := '10';
end;

function sx( x : Extended) : Extended;
var
  i : LongInt;
  res,a : Extended;
begin
  res := 0;
  a := 1;
  for i := 1 to m do begin
    a := a * x / i;
    res := res + a;
  end;
  sx := res;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  memo1.Clear;
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  n := StrToInt(Edit3.Text);
  m := StrToInt(Edit4.Text);
  tabl(a,b,n,sx,Memo1);
end;

end.
