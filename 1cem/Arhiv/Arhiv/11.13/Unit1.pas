unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls;

type
  zap=record
    fam:string[15];
    a1,a2,a3:integer;
    sr:extended;
    ind:boolean;
   end;
  zapmas=array of zap;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid2: TStringGrid;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure vivod;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,n,m:integer;
  a:zapmas;
  w:zap;

implementation

{$R *.dfm}

procedure add1(avs:zap; nvs:integer);
var k:integer;
begin
 SetLength(a,high(a)+2);
 For k:=high(a)-1 downto nvs do a[k+1]:=a[k];
 a[nvs]:=avs;
end;

procedure del1(nyd:integer);
var k:integer;
begin
 For k:=nyd+1 to high(a) do a[k-1]:=a[k];
 SetLength(a,high(a));
end;

procedure TForm1.vivod;
var i:integer;
begin
 stringgrid1.rowcount:=high(a)+2;
 if high(a)=-1 then stringgrid1.fixedrows:=0
  else stringgrid1.fixedrows:=1;
 for i:=0 to high(a) do
  begin
   stringgrid1.Cells[0,i+1]:=inttostr(i+1);
   stringgrid1.Cells[1,i+1]:=a[i].fam;
   stringgrid1.Cells[2,i+1]:=inttostr(a[i].a1);
   stringgrid1.Cells[3,i+1]:=inttostr(a[i].a2);
   stringgrid1.Cells[4,i+1]:=inttostr(a[i].a3);
  end;
end;

procedure PuzSort(var b:array of zap; r:integer);
var l,kol:integer;
    w:zap;
    p:boolean;
begin
kol:=1;
repeat
p:=true;
for l:=0 to r-kol do
if b[l].fam>b[l+1].fam then
 begin
  w:=b[l];
  b[l]:=b[l+1];
  b[l+1]:=w;
  p:=false;
 end;
inc(kol);
until p;
end;

function chek:extended;
var s:extended;
begin
 s:=0;
 for i:=0 to high(a) do
  begin
   if (a[i].a1=5) and (a[i].a2=5) and (a[i].a3=5) then a[i].ind:=true;
   a[i].sr:=(a[i].a1+a[i].a2+a[i].a3)/3;
   s:=s+a[i].sr;
  end;
 result:=s/(high(a)+1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 a:=nil;
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid2.Visible:=false;
 stringgrid1.Cells[0,0]:='№';
 stringgrid1.Cells[1,0]:='Фамилия';
 stringgrid1.Cells[2,0]:='Матем';
 stringgrid1.Cells[3,0]:='Физика';
 stringgrid1.Cells[4,0]:='Язык';
 stringgrid2.Cells[0,0]:='Фамилия';
 stringgrid2.Cells[1,0]:='Бал';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 puzsort(a,high(a));
 vivod;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 j:=strtoint(Edit6.Text)-1;
 if n>high(a) then
  begin
   ShowMessage('Проверьте значение!');
   exit;
  end;
 del1(j); Edit6.Clear;
 vivod;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 w.fam:=edit1.Text;
 w.a1:=strtoint(edit2.Text);
 w.a2:=strtoint(edit3.Text);
 w.a3:=strtoint(edit4.Text);
 if Edit5.Text<>'' then j:=strtoint(Edit5.Text)-1 else j:=high(a)+1;
 if high(a)=-1 then
  begin
   setlength(a,1);
   a[0]:=w;
  end
 else add1(w,j);
 vivod;
 edit5.Text:='';
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if high(A)<>-1 then
  for i:=0 to n do
   for j:=0 to 4 do
    begin
     stringgrid1.Cells[j,i+1]:='';
     stringgrid2.Cells[j,i+1]:='';
    end;
 a:=nil;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 stringgrid1.FixedRows:=0;
 stringgrid1.rowcount:=1;
 stringgrid2.FixedRows:=1;
 stringgrid2.rowcount:=2;
 stringgrid2.Visible:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
 var s:extended;
begin
 stringgrid2.Visible:=true;
 s:=chek;
 m:=0;
 for i:=0 to high(a) do
  if a[i].ind then
   begin
    inc(m);
    stringgrid2.Cells[0,m]:=a[i].fam;
    stringgrid2.Cells[1,m]:=floattostrf(a[i].sr,fffixed,6,2);
   end;
 for i:=0 to high(a) do
  if (not a[i].ind) and (a[i].sr>s) then
   begin
    inc(m);
    stringgrid2.Cells[0,m]:=a[i].fam;
    stringgrid2.Cells[1,m]:=floattostrf(a[i].sr,fffixed,6,2);
   end;
  stringgrid2.RowCount:=m+1;  
end;

end.
