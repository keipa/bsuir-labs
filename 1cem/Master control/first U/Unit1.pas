unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids, unit2;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;  a: ppas; n:Integer;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
 var
 i:Integer;

begin

n:=strtoint(edt1.Text);
GetMem(a,n*sizeof(Integer));
strng
for i:=1 to n-1 do
strngrd1.Cells[i,0]:=IntToStr(Random(20));





end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Randomize;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
FreeMem(a,n*sizeof(Integer));
end;

end.
