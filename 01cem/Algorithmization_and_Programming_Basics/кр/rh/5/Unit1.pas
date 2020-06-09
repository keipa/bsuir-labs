unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    RadiouGroup1: TRadioGroup;
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
  res,n : longint;
  bl : Boolean;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.text := '11223';
  Memo1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  bl := RadiouGroup1.ItemIndex = 0;
  n := StrToInt(Edit1.Text);
  res := Find(n,bl);
  if bl then Memo1.Lines.Add('сумма = '+IntToStr(res))
  else Memo1.Lines.Add('произведение цифр = ' +IntToStr(res));
end;

end.
