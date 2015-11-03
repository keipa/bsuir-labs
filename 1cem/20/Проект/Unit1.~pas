unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Unit2;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  L:TListMs;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i,j,N:integer;
begin
  LabeledEdit1.Text:='5';
  N:=StrToInt(LabeledEdit1.Text);
  Randomize;
  for i:=0 to N-1 do
    for j:=0 to N-1 do
      StringGrid1.Cells[j,i]:=IntToStr(Random(10)+3);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var N,i,j:integer;
    d:extended;
begin
  LabeledEdit2.Clear;
  N:=StrToInt(LabeledEdit1.Text);
  L:=TListMs.Create(N,N);
  for i:=0 to N-1 do
    for j:=0 to N-1 do
      L.Addj(i+1,j+1,StrToFloat(StringGrid1.Cells[j,i]));
  L.TrVid;
  d:=1;
  with L do
    begin
      for i:=1 to N do
        d:=d*ms[i].readsj(i);
      LabeledEdit2.Text:=FloatToStr(d);
    end;
  L.Free;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var N,i,j:integer;
begin
  N:=StrToInt(LabeledEdit1.Text);
  StringGrid1.ColCount:=N;
  StringGrid1.RowCount:=N;
  Randomize;
  for i:=0 to N-1 do
    for j:=0 to N-1 do
      StringGrid1.Cells[j,i]:=IntToStr(Random(10)+3);
end;

end.
