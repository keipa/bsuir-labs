unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons;

type
  rasp=record
    num:string[5];
    pun:string[20];
    time:TDateTime;
   end;
  rasp1=record
    num:string[5];
    time:TDateTime;
   end;
  raspmas=array of rasp;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit4: TEdit;
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
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vivod;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,n:integer;
  a:raspmas;
  w:rasp;

implementation

{$R *.dfm}

procedure add1(avs:rasp; nvs:integer);
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
   stringgrid1.Cells[1,i+1]:=a[i].num;
   stringgrid1.Cells[2,i+1]:=a[i].pun;
   stringgrid1.Cells[3,i+1]:=timetostr(a[i].time);
  end;
end;

procedure PuzSort(var b:array of rasp; r:integer);
var l,kol:integer;
    w:rasp;
    p:boolean;
begin
kol:=1;
repeat
p:=true;
for l:=0 to r-kol do
if b[l].pun>b[l+1].pun then
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
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid1.Cells[0,0]:='Номер';
 stringgrid1.Cells[1,0]:='Рейс';
 stringgrid1.Cells[2,0]:='Пункт назначения';
 stringgrid1.Cells[3,0]:='Время';
 Memo1.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 w.num:=Edit1.Text;
 w.pun:=Edit2.Text;
 w.time:=strtotime(Edit3.Text);
 if Edit5.Text<>'' then j:=strtoint(Edit5.Text)-1 else j:=high(a)+1;
 if high(a)=-1 then
  begin
   setlength(a,1);
   a[0]:=w;
  end
 else add1(w,j);
 vivod;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit5.Text:='';
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
var s:string;
b:array of rasp1;
k,m:integer;
t:rasp1;
begin
if key=#13 then
begin
 setlength(b,high(a)+1);
 m:=0;
 s:=Edit4.Text;
 Memo1.Clear;
 memo1.Lines.add('Пункт назначения: '+s);
 for i:=0 to high(a)+1 do
  if a[i].pun=s then
   begin
    inc(m);
    b[m].num:=a[i].num;
    b[m].time:=a[i].time;
   end;
 if m=0 then
  begin
   Memo1.Lines.Add('Рейсов по данному маршруту не запланировано');
   exit;
  end;
 for k:=1 to m-1 do
  for i:=1 to m-k do
   if b[i].time>b[i+1].time then
    begin
     t:=b[i+1];
     b[i+1]:=b[i];
     b[i]:=t;
    end;
 for i:=1 to m do
  memo1.Lines.add(b[i].num+'         '+timetostr(b[i].time));
 b:=nil;
end;
end;

procedure TForm1.Button5Click(Sender: TObject);
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

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 a:=nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 PuzSort(a,high(a));
 vivod;
end;

end.
