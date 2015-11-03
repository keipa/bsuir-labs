unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    StringGrid2: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Nmax=10;
Type
  Mas2=array [1..Nmax,1..Nmax] of extended;
var
  Form1: TForm1;
  A:Mas2;
  N,M,i,j,k,l:integer;
  min,max,R:extended;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
N:=3;
M:=3;
Edit1.Text:=FloatToStr(N);
Edit2.Text:=FloatToStr(M);
StringGrid1.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
StringGrid1.Cells[0,0]:='Massiv A:';
for i:=1 to N do
  begin
    StringGrid1.Cells[0,i]:='i='+IntToStr(i);
    StringGrid1.Cells[i,0]:='K='+IntToStr(i);
  end;
stringgrid2.Cells[0,0]:='Massiv B';
  for i:=1 to N do
  begin
    StringGrid2.Cells[0,i]:='K='+IntToStr(i);
  end;
end;





procedure TForm1.Button2Click(Sender: TObject);
      begin


     for j:=1 to m do
      for i:=1 to n do
         if A[i,j] = 0 then
            StringGrid2.Cells[1,j]:= 0 ;
         else    StringGrid2.Cells[1,j]:= 1 abort;  {cycle break}





{ try
  max:=A[1,1];
  min:=A[1,1];
  k:=1;
  l:=1;
  for i:=1 to N do
    for j:=1 to M do
      begin
        if max<A[i,j] then
          begin
            max:=A[i,j];
            k:=i;
          end;
        if min>A[i,j] then
          begin
            min:=A[i,j];
            l:=i;
          end;
      end;
  for j:=1 to M do
    begin
      R:=A[k,j];
      A[k,j]:=A[l,j];
      A[l,j]:=R;
    end;
  except
    on EInvalidOp do
      begin
        MessageDlg('Nepravilnaya operaciya s plavauschei tochloi',mtError,[mbCancel],0);
        Exit;
      end;
    on EOverFlow do
      begin
        MessageDlg('Perepolnenie pri vipolnenii operacii s plavauschei tochkoi',mtError,[mbCancel],0);
        Exit;
      end;
    else
      begin
        MessageDlg('Voznikla neizvestnaya iskluchitelnaya situaciya!',mtError,[mbCancel],0);
        Exit;
      end;
 end;
  for i:=1 to N do
    for j:=1 to M do
      StringGrid1.Cells[j,i]:=FloatToStrF(A[i,j],ffFixed,6,0);
      }

      end;



procedure TForm1.Button1Click(Sender: TObject);
begin
N:=StrToInt(Edit1.Text);
M:=StrToInt(Edit2.Text);
StringGrid1.RowCount:=N+1;
StringGrid2.RowCount:=N+1;
StringGrid1.ColCount:=M+1;
for i:=1 to N do
  StringGrid1.Cells[0,i]:=' i= '+IntToStr(i);
  for i:=1 to N do
  StringGrid2.Cells[0,i]:=' K= '+IntToStr(i);
for i:=1 to M do
  StringGrid1.Cells[i,0]:=' j= '+IntToStr(i);
end;




end.
