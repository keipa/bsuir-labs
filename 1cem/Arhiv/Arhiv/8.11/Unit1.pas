unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

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
  raspmas=array[1..100] of rasp;
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    procedure groupup(a:raspmas);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
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
  f:file of rasp;

implementation

{$R *.dfm}

procedure TForm1.groupup(a:raspmas);
var b:array[1..100] of string;
m:integer;
begin
 m:=0;
 groupbox1.visible:=true;
 Memo1.Clear;
 combobox1.Text:='';
 combobox1.Items.Clear;
 for i:=1 to n do
  begin
   j:=1;
   while (a[i].pun<>b[j]) and (j<=m) do inc(j);
   if j>m then
    begin
     b[j]:=a[i].pun;
     inc(m);
    end;
  end;
 ComboBox1.DropDownCount:=m;
 for i:=1 to m do
  combobox1.Items.Append(b[i]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid1.Cells[0,0]:='Номер';
 stringgrid1.Cells[1,0]:='Пункт назначения';
 stringgrid1.Cells[2,0]:='Время';
 GroupBox1.Visible:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  begin
   assignfile(f,opendialog1.FileName);
   reset(f);
  end
 else Exit;
 if n<>0 then
  for i:=1 to n do
   for j:=0 to 2 do
    stringgrid1.Cells[j,i]:='';
 n:=0;
 while not eof(f) do
  begin
   inc(n);
   read(f,w);
   a[n]:=w;
  end;
 stringgrid1.RowCount:=n+1;
 stringgrid1.FixedRows:=1;
 stringgrid1.Cells[0,0]:='Номер';
 stringgrid1.Cells[1,0]:='Пункт назначения';
 stringgrid1.Cells[2,0]:='Время';
 for i:=1 to n do
  begin
   stringgrid1.Cells[0,i]:=a[i].num;
   stringgrid1.Cells[1,i]:=a[i].pun;
   stringgrid1.Cells[2,i]:=timetostr(a[i].time);
  end;
 closefile(f);
 groupup(a);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if savedialog1.Execute then
  begin
   assignfile(f,savedialog1.filename);
   rewrite(f);
  end
 else Exit;
 n:=0;
 while stringgrid1.Cells[0,n+1]<>'' do
  begin
   n:=n+1;
   w.num:=stringgrid1.Cells[0,n];
   w.pun:=stringgrid1.Cells[1,n];
   w.time:=strtotime(stringgrid1.Cells[2,n]);
   a[n]:=w;
   write(f,w);
  end;
 closefile(f);
 groupup(a);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 inc(n);
 stringgrid1.rowcount:=n+1;
 stringgrid1.fixedrows:=1;
 a[n].num:=edit1.Text;
 a[n].pun:=edit2.Text;
 a[n].time:=strtotime(edit3.Text);
 stringgrid1.Cells[0,n]:=edit1.Text;
 stringgrid1.Cells[1,n]:=edit2.Text;
 stringgrid1.Cells[2,n]:=timetostr(a[n].time);
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 groupup(a);
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
var s:string;
b:array of rasp1;
k,m:integer;
t:rasp1;
begin
if key=#13 then
begin
 setlength(b,n+1);
 m:=0;
 s:=combobox1.Text;
 Memo1.Clear;
 memo1.Lines.add('Пункт назначения: '+s);
 for i:=1 to n do
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

procedure TForm1.Button4Click(Sender: TObject);
begin
 if n<>0 then
  for i:=1 to n do
   for j:=0 to 2 do
    stringgrid1.Cells[j,i]:='';
 n:=0;
 stringgrid1.FixedRows:=0;
 stringgrid1.rowcount:=1;
 groupbox1.Visible:=false;
end;

end.
