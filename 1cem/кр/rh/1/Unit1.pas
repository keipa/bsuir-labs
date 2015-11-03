unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit2, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  a, e, q : Extended;
begin
  a := StrToFloat(Edit1.Text);
  e := StrToFloat(Edit2.Text);
  q := solve(a,e);
  Edit3.Text := FloatToStrF(q, ffFixed,8,4);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '1';
  Edit2.Text := '0,0001';
end;

end.
