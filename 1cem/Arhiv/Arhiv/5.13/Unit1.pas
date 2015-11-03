unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    StringGrid2: TStringGrid;
    Label3: TLabel;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 var
   Form1: TForm1;
   A:array of char;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=5; Edit1.Text:=inttostr(N);
  StringGrid1.ColCount:=N;
  StringGrid2.ColCount:=N;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N;
  StringGrid2.ColCount:=N;
end;

procedure TForm1.Button2Click(Sender: TObject);
 var k:integer;
     t:char;
begin
 SetLength(a,n+1);
 for i:=1 to N do
  A[i]:=StringGrid1.Cells[i-1,0][1];

 i:=1;
 while i<=n do
  begin
   for j:=1 to i do if a[i]=a[j] then break;
   if j<>i then
    begin
     for j:=i+1 to n do a[j-1]:=a[j];
     dec(n);
     dec(i);
    end;
   inc(i);
  end;

 StringGrid2.ColCount:=N;
 for i:=1 to n do stringgrid2.cells[i-1,0]:=a[i];
 a:=nil;
end;

end.

