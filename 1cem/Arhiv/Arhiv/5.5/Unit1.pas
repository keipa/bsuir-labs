unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    StringGrid2: TStringGrid;
    Edit2: TEdit;
    Label3: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  Type
	TMas = array of char;

var
  Form1: TForm1;
  k,n : integer ;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
n:=5;
k:=1;
Edit1.Text:=IntToStr(n);
Edit2.Text:=IntToStr(k) ;
StringGrid1.ColCount:=n+1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
n:=StrToInt(Edit1.Text);
k:=StrToInt(Edit2.Text);
StringGrid1.ColCount:=n+1;
StringGrid2.ColCount:=n+1;
end;

procedure TForm1.Button2Click(Sender: TObject);
 var
 i, j, z : integer ;
 a : Tmas;
begin
try
GetMem(a,N*sizeof(string));
{z:=length(a)  ;}
for i:=1 to n do
  a[i ]:=StringGrid1.Cells[i,0][1];
for j := 1 to k do
  begin
    for i := 1 to n do
      a[i] := a[i+1];
  end;
for i:=0 to n - 1 do
  Stringgrid2.Cells[i+1,0]:=a[i];
for i:=n-k to n do
for z:=1 to n-k do
  begin
  Stringgrid2.Cells[i+1,0]:=a[z];
  end;
  FreeMem(a,N*sizeof(string));
  except
  end;
end;
end.
