unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Ran:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
memo1.Clear;
if ran=0 then
  memo1.lines.Add('Generate new number');
if strtoint(edit1.Text)=0 then
  memo1.lines.Add('enter number');

if strtoint(edit1.Text)>ran then
  memo1.lines.Add('smaller');
if strtoint(edit1.Text)<ran  then
  memo1.lines.Add('BIGGER');
if strtoint(edit1.Text)=ran then
  memo1.lines.Add('You win');

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Randomize;
  Ran:=random(100);
  memo1.lines.Add('NUMBER GENERATED');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Ran:=0;
  memo1.Clear;

end;

end.
