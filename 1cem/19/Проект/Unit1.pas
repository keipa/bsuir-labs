unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, UHesh;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    BitBtn7: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn8: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  T: TH;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var M: integer;
begin
  with StringGrid1 do
    begin
      Cells[0,0]:='Иванов А.А.';    Cells[1,0]:='100005';
      Cells[0,1]:='Петров С.И.';	  Cells[1,1]:='100002';
      Cells[0,2]:='Сидоров К.М.';   Cells[1,2]:='100004';
      Cells[0,3]:='Васильев М.К.';  Cells[1,3]:='100001';
      Cells[0,4]:='Смирнов В.К.';   Cells[1,4]:='100007';
      Cells[0,5]:='Мишин Т.В.';     Cells[1,5]:='100006';
      Cells[0,6]:='Долин А.К.';	    Cells[1,6]:='100008';
      Cells[0,7]:='Катаев А.М.';    Cells[1,7]:='100000';
    end;
  RadioGroup1.ItemIndex:=0;
  Edit1.Text:='8';
  Memo1.Clear;
  M:=StrToInt(Edit1.Text);
  T:=TH.Create(M);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var n, i: integer;
    inf: TInf;
begin
  n:=StrToInt(Edit1.Text);
  for i:=1 to n do
    begin
      Inf.Fio:=StringGrid1.Cells[0,i-1];
      Inf.key:=StrToInt(StringGrid1.Cells[1,i-1]);
      T.Add(inf);
    end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var x: TInf;
begin
  Memo1.Clear;
  x.FIO:=LabeledEdit1.Text;
  x.Key:=StrToInt(LabeledEdit2.Text);
  T.Add(x);
  T.Print(Memo1);
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var x:integer;
    y:TInf;
begin
  x:=StrToInt(LabeledEdit3.Text);
  case RadioGroup1.ItemIndex of
    0:  T.ReadDel(x,y);
    1:  T.Read(x,y);
  end;
  Memo1.Clear;
  Memo1.Lines.Add(y.Fio+' '+IntToStr(y.Key));
  LabeledEdit3.Clear;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  Memo1.Clear;
  T.Print(Memo1);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  Memo1.Clear;
  StringGrid1.ColCount:=2;
  StringGrid1.RowCount:=T.n;
  T.Free(StringGrid1);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  T.Srednee;
  sr:=sum/num;
  Memo1.Clear;
  Memo1.Lines.Add('Среднее значение ключей: '+FloatToStr(sr));
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Memo1.Clear;
  T.PrintSr(Memo1);
end;

end.
