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
  a,b,h,min : extended;


implementation

{$R *.dfm}

function sx( x : Extended) : extended;
begin
  sx := sqr(x - 1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.Text := '1';
  Edit2.Text := '2';
  Edit3.Text := '0,01';
  Edit4.Text := '?';
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  a := strtofloat(edit1.text);
  b := strtofloat(edit2.text);
  h := strtofloat(edit3.text);
  min := fmin(a,b,h,sx);
  edit4.text := floattostrf(min,fffixed,8,3);
end;

end.
