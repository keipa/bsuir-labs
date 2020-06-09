unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
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
  memo1.clear;       
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : longint;
begin
  Memo1.Clear;
  for i := 100 to 999 do if ok(i) then Memo1.Lines.Add(IntToStr(i));
end;

end.
