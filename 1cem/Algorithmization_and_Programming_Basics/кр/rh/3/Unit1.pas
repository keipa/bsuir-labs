unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
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
  x,eps,s : Extended;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.text := '1';
  edit2.Text := '0,00001';
  Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  x := strtofloat(edit1.text);
  eps := strtofloat(edit2.text);
  s := find(x,eps);
  Memo1.lines.add(floattostrf(s,fffixed,8,3));
end;

end.
