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
    Label4: TLabel;
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
  x0,x1,e,xp : Extended;
  p : LongInt;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '1';
  Edit2.Text := '2';
  Edit3.Text := '10';
  Edit4.Text := '0,0001';
  Memo1.clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  e := StrToFloat(Edit4.text);
  x0 := StrToFloat(Edit1.Text);
  x1 := StrToFloat(Edit2.Text);
  a := Strtofloat(Edit3.Text);
  xp := find(x0,x1,e,p);
  if p = 0 then Memo1.Lines.Add('Нет сходимости')
  else begin
    Memo1.Lines.Add('Предел = ' +floattostrf(xp,ffFixed,8,3));
    Memo1.Lines.Add('Количество итераций = ' +inttostr(p));
  end;
end;

end.
