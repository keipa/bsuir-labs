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
  edit1.Text := 'abacaba';
  Edit2.Text :='3';

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ans : LongInt;
  s : string;
begin
  s := Edit1.Text;
  ans := calculate(s);
  Edit2.Text := IntToStr(ans);
end;

end.
