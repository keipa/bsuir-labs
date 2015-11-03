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
  zapmas=array[1..100] of zap;
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid2: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,n,m:integer;
  a,b:zapmas;
  w:zap;
  f:file of zap;
  ft:textfile;

implementation

{$R *.dfm}

function chek:extended;
var s:extended;
begin
 s:=0;
 for i:=1 to n do
  begin
   if (a[i].a1=5) and (a[i].a2=5) and (a[i].a3=5) then a[i].ind:=true;
   a[i].sr:=(a[i].a1+a[i].a2+a[i].a3)/3;
   s:=s+a[i].sr;
  end;
 result:=s/n;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid2.Visible:=false;
 stringgrid1.Cells[0,0]:='Фамилия';
 stringgrid1.Cells[1,0]:='Матем';
 stringgrid1.Cells[2,0]:='Физика';
 stringgrid1.Cells[3,0]:='Язык';
 stringgrid2.Cells[0,0]:='Фамилия';
 stringgrid2.Cells[1,0]:='Бал';
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
   for j:=0 to 3 do
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
 for i:=1 to n do
  begin
   stringgrid1.Cells[0,i]:=a[i].fam;
   stringgrid1.Cells[1,i]:=inttostr(a[i].a1);
   stringgrid1.Cells[2,i]:=inttostr(a[i].a2);
   stringgrid1.Cells[3,i]:=inttostr(a[i].a3);
  end;
 closefile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Savedialog1.Title:='Сохранить базу';
 Savedialog1.DefaultExt:='dat';
 if savedialog1.Execute then
  begin
   assignfile(f,savedialog1.filename);
   rewrite(f);
  end
 else Exit;
 for i:=1 to n do write(f,a[i]);
 closefile(f);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 inc(n);
 stringgrid1.rowcount:=n+1;
 stringgrid1.fixedrows:=1;
 a[n].fam:=edit1.Text;
 a[n].a1:=strtoint(edit2.Text);
 a[n].a2:=strtoint(edit3.Text);
 a[n].a3:=strtoint(edit4.Text);
 stringgrid1.Cells[0,n]:=edit1.Text;
 stringgrid1.Cells[1,n]:=edit2.Text;
 stringgrid1.Cells[2,n]:=edit3.text;
 stringgrid1.cells[3,n]:=edit4.text;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if n<>0 then
  for i:=1 to n do
   for j:=0 to 3 do
    begin
     stringgrid1.Cells[j,i]:='';
     stringgrid2.Cells[j,i]:='';
    end;
 n:=0;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
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
 stringgrid2.RowCount:=n+1;
 for i:=1 to n do
  if a[i].ind then
   begin
    inc(m);
    stringgrid2.Cells[0,m]:=a[i].fam;
    stringgrid2.Cells[1,m]:=floattostrf(a[i].sr,fffixed,6,2);
   end;
 for i:=1 to n do
  if (not a[i].ind) and (a[i].sr>s) then
   begin
    inc(m);
    stringgrid2.Cells[0,m]:=a[i].fam;
    stringgrid2.Cells[1,m]:=floattostrf(a[i].sr,fffixed,6,2);
   end;
end;

procedure TForm1.Button6Click(Sender: TObject);
 var s:extended;
begin
 s:=chek;
 Savedialog1.Title:='Сохранить в текстовый файл';
 Savedialog1.DefaultExt:='txt';
 if savedialog1.Execute then
  begin
   assignfile(ft,savedialog1.filename);
   rewrite(ft);
  end
 else Exit;
 writeln(ft,'        Список хороших учеников');
 writeln(ft,'  Фамилия     Средний бал');
 for i:=1 to n do
  if a[i].ind then writeln(ft,a[i].fam:15,a[i].sr:6:2);
 for i:=1 to n do
  if (not a[i].ind) and (a[i].sr>s) then writeln(ft,a[i].fam:15,a[i].sr:6:2);
 closefile(ft);
end;

end.
