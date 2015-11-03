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
    Label3: TLabel;
    Label4: TLabel;
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
  lcd,n,m,gcd : LongInt;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '123';
  Edit2.Text := '246';
  edit3.Text :='123';
  Edit4.text := '246';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  n := strtoint(Edit1.Text);
  m := strtoint(edit2.Text);
  fdk(n,m,gcd,lcd);
  edit3.Text := IntToStr(gcd);
  Edit4.Text := IntToStr(lcd);
end;

end.
