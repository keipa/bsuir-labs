unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, unit2;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    btn1: TButton;
    btn2: TButton;
    edt1: TEdit;
    strngrd3: TStringGrid;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.btn1Click(Sender: TObject);
var
a:am;
b:bm;
c:cm;
i:Integer;
begin
  mmo1.clear;
 GetMem(a,strngrd1.ColCount* SizeOf(Integer));
  GetMem(b,strngrd2.ColCount* SizeOf(Integer));
    GetMem(c,(strngrd2.ColCount+strngrd1.ColCount)*SizeOf(Integer));
  for i:=1 to strngrd1.ColCount-1 do begin
    a[i]:=strtoint(strngrd1.Cells[i,1]);
    b[i]:=strtoint(strngrd2.Cells[i,1]);
  end;
  plusort(strngrd1.ColCount-1,strngrd2.ColCount-1,strngrd3);

end;

end.
