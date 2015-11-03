unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, ComCtrls;

type
  zap=record
    fam:string[10];
    adr:string[20];
    date:TDate;
   end;
  zapmas=array of zap;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Edit5: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit6: TEdit;
    Button5: TButton;
    Label8: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    StringGrid2: TStringGrid;
    Button2: TButton;
    DateTimePicker1: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vivod;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,n,m:integer;
  a:zapmas;
  b:array[1..100] of zap;
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
 stringgrid1.fixedrows:=1;
 for i:=0 to high(a) do
  begin
   stringgrid1.Cells[0,i+1]:=inttostr(i+1);
   stringgrid1.Cells[1,i+1]:=a[i].fam;
   stringgrid1.Cells[2,i+1]:=a[i].adr;
   stringgrid1.Cells[3,i+1]:=datetostr(a[i].date);
  end;
end;

procedure filtr;
var ind:boolean;
begin
 m:=0;
 for i:=0 to high(a) do
  begin
   ind:=true;
   for j:=1 to m do
    if (a[i].fam=b[j].fam) and (a[i].adr=b[j].adr) then ind:=false;
   if ind then
    begin
     inc(m);
     b[m]:=a[i];
    end;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 datetimepicker1.Date:=date;
 edit5.Text:='';
 edit6.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid2.Visible:=false;
 stringgrid1.Cells[0,0]:='Номер';
 stringgrid1.Cells[1,0]:='Фамилия';
 stringgrid1.Cells[2,0]:='Адрес';
 stringgrid1.Cells[3,0]:='Дата';
 stringgrid2.Cells[0,0]:='Номер';
 stringgrid2.Cells[1,0]:='Фамилия';
 stringgrid2.Cells[2,0]:='Адрес';
 stringgrid2.Cells[3,0]:='Дата';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 w.fam:=Edit1.Text;
 w.adr:=Edit2.Text;
 w.date:=Datetimepicker1.Date;
 if (Edit5.Text<>'') and (strtoint(edit5.Text)<high(a)+1) then j:=strtoint(Edit5.Text)-1 else j:=high(a)+1;
 if high(a)=-1 then
  begin
   setlength(a,1);
   a[0]:=w;
  end
 else add1(w,j);
 vivod;
 edit1.Text:='';
 edit2.Text:='';
 datetimepicker1.Date:=date;
 edit5.Text:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 j:=strtoint(Edit6.Text)-1;
 if j>high(a) then
  begin
   ShowMessage('Проверьте значение!');
   exit;
  end;
 del1(j); Edit6.Clear;
 vivod;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 a:=nil;
end;
            
procedure TForm1.Button1Click(Sender: TObject);
begin
 PuzSort(a,high(a));
 vivod;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 a:=nil;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 filtr;
 stringgrid2.Visible:=true;
  stringgrid2.RowCount:=M+1;
 for i:=1 to m do
  begin
   stringgrid2.Cells[0,i]:=inttostr(i);
   stringgrid2.Cells[1,i]:=b[i].fam;
   stringgrid2.Cells[2,i]:=b[i].adr;
   stringgrid2.Cells[3,i]:=datetostr(b[i].date);
  end;
end;

end.
