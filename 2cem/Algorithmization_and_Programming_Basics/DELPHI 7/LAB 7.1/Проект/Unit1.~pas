unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, Unit2;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    edt1: TEdit;
    edt2: TEdit;
    lbl1: TLabel;
    edt3: TEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Stek: CStack;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  with Strngrd1 do
    begin
      Cells[0,0]:='name'; Cells[1,0]:='znach';
      Cells[0,1]:='a';    Cells[1,1]:='1';
      Cells[0,2]:='b';    Cells[1,2]:='2';
      Cells[0,3]:='c';    Cells[1,3]:='3';
      Cells[0,4]:='d';    Cells[1,4]:='2';
      Cells[0,5]:='e';    Cells[1,5]:='5';
    end;
  edt1.Text:='((a-b+c)/d)^e';
  edt2.Clear;
  edt3.Clear;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  i: byte;
  ch: char;
  strp: string;
begin
  strp:=edt2.Text;
  for i:=1 to 5 do
    begin
      ch:=Strngrd1.Cells[0,i][1];
      mszn[Ord(ch)]:=StrToFloat(strngrd1.Cells[1,i]);
    end;
  edt3.Text:=FloatToStr(Stek.AV(strp));
end;

procedure TForm1.btn1Click(Sender: TObject);
var stri, strp: string;
begin
  stri:=edt1.Text;
  Stek.OBP(stri,strp);
  edt2.Text:=strp;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  edt1.Clear;
  edt2.clear;
  edt3.Clear;
end;

end.
