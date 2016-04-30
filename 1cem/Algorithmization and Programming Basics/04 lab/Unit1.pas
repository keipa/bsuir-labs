unit Unit1;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
Forms, Dialogs, Grids, StdCtrls, mxarrays, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 const
 nmax=10;
 type
 mas2 = array[1..nmax,1..nmax] of extended;
 mas1 = array[1..nmax] of extended;

var
  Form1: TForm1;
A: mas2;
B,Y:mas1;
n, m,i,j:integer;
implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
n:=3;
m:=3;
edit1.Text:=floattostr(n);
edit2.Text:=floattostr(m);
stringgrid1.RowCount:=n+1;
stringgrid1.colCount:=m+1;
stringgrid2.Rowcount:=n+1;
stringgrid3.Rowcount:=n+1;
stringgrid1.Cells[0,0]:='Array A';
stringgrid2.Cells[0,0]:='Array B';
stringgrid3.Cells[0,0]:='Array C';
for i:=1 to n do begin
stringgrid1.Cells[0,i]:='i='+inttostr(i);
stringgrid1.Cells[i,0]:='j='+inttostr(i);
   end;
end;

 procedure TForm1.Button1Click(Sender: TObject);
   {%R+}
 try
 for i:=1 to N do
 for j:=1 to M do
 A[i,j]:=StrToFloat(StringGrid1.Cells[j,i]);

 for i:=1 to N do
 B[i]:=StrToFloat(StringGrid2.Cells[0,i]);
 except
 on ERangeError do begin ShowMessage('Going beyond the array. Reduce the size of the array'); Exit; end;
 on EConvertError do begin ShowMessage(' there is no value in the cell  or number is not entered correctly'); Exit; end;
 else begin ShowMessage('Unique situation !'); Exit; end;
 end;

 try

 for i:=1 to N do begin
 Y[i]:=0;
  for j:=1 to M do Y[i]:=Y[i]+A[i,j]*B[j];
 end;
 except
 on EInvalidOp do begin MessageDlg('Improper operation withfloating-point',mtError,[mbCancel],0);Exit; end;
 on EOverFlow do begin MessageDlg('Overflow when performing floating point operations',mtError,[mbCancel],0); Exit; end;
 else begin MessageDlg('An unknown exception situation',mtError,[mbCancel],0); Exit; end;
 end;
 for i:=1 to N do StringGrid3.Cells[0,i]:=FloatToStrf(y[i],fffixed,6,0);
end;
end.

procedure TForm1.Button2Click(Sender: TObject);
begin
n:=strtoint(edit1.text);
m:=strtoint(edit2.text);
stringgrid1.RowCount:=n+1;
stringgrid1.colCount:=m+1;
stringgrid2.Rowcount:=n+1;
stringgrid3.Rowcount:=n+1;
for i:=1 to N do StringGrid1.Cells[0,i]:=' i= '+IntToStr(i);
for i:=1 to M do StringGrid1.Cells[i,0]:=' j= '+IntToStr(i);
end;




end.
