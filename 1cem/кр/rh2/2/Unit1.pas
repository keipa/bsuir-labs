unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    SaveDiaog1: TSaveDialog;
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
  ft : textfile;
  m : LongInt;
  filenamet : string;
  a,b : Extended;
  n : LongInt;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '1';
  Edit2.Text := '2';
  Edit3.Text := '10';
  Edit4.Text := '10';
end;

function sx( x : Extended) : Extended;
var
  i,j,k : LongInt;
  q : extended;
  ans : extended;
begin
  q := 1;
  ans := 0;
  for k :=1 to m do begin
    q := q * x / k;
    ans := ans + q;
  end;
  sx := ans;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SaveDiaog1.Execute then begin
    filenamet := SaveDiaog1.FileName;
    AssignFile(ft,filenamet);
    Rewrite(ft);
  end;
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  n := StrToInt(Edit3.Text);
  m := StrToInt(Edit4.Text);
  tabl(a,b,n,sx,ft);
end;

end.
