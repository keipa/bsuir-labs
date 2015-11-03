unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  spis=record
    str:string[20];
    kom:string[20];
    fio:string[20];
    num:integer;
    let:integer;
    rost:integer;
    ves:integer;
   end;
  spismas=array[1..100] of spis;
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Button5: TButton;
    Button6: TButton;
    StringGrid2: TStringGrid;
    procedure vivod(i,n:integer; SG:TStringGrid);
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

type Tpoisk=record
      kom:string;
      let:integer;
      num:integer;
     end;
var
  Form1: TForm1;
  i,j,n:integer;
  a:spismas;
  w:spis;
  f:file of spis;
  ft:textfile;

implementation

{$R *.dfm}

procedure TForm1.vivod(i,n:integer; SG:TStringGrid);
begin
 SG.Cells[0,i]:=a[n].str;
 SG.Cells[1,i]:=a[n].kom;
 SG.Cells[2,i]:=a[n].fio;
 SG.Cells[3,i]:=inttostr(a[n].num);
 SG.Cells[4,i]:=inttostr(a[n].let);
 SG.Cells[5,i]:=inttostr(a[n].rost);
 SG.Cells[6,i]:=inttostr(a[n].ves);
end;

function poisk:string;
var p:array of Tpoisk;
ind:boolean;
m:integer;
min:extended;
mink:string;
begin
 m:=0;
 setlength(p,n+1);
 for i:=1 to n do
  begin
   ind:=false;
   for j:=1 to m do
    if a[i].kom=p[j].kom then
     begin
      p[j].let:=p[j].let+a[i].let;
      inc(p[j].num);
      ind:=true;
     end;
   if not ind then
    begin
     inc(m);
     p[m].kom:=a[i].kom;
     p[m].let:=a[i].let;
     p[m].num:=1;
    end;
  end;
 mink:=p[1].kom;
 min:=p[1].let/p[1].num;
 if m>1 then
  for i:=2 to m do
   if (p[i].let/p[i].num)<min then
    begin
     min:=p[i].let/p[i].num;
     mink:=p[i].kom;
    end;
 result:=mink;
 p:=nil;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 edit7.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid1.Cells[0,0]:='Страна';
 stringgrid1.Cells[1,0]:='Команда';
 stringgrid1.Cells[2,0]:='Ф.И.О.';
 stringgrid1.Cells[3,0]:='Номер';
 stringgrid1.Cells[4,0]:='Возраст';
 stringgrid1.Cells[5,0]:='Рост';
 stringgrid1.Cells[6,0]:='Вес';
 stringgrid2.Cells[0,0]:='Страна';
 stringgrid2.Cells[1,0]:='Команда';
 stringgrid2.Cells[2,0]:='Ф.И.О.';
 stringgrid2.Cells[3,0]:='Номер';
 stringgrid2.Cells[4,0]:='Возраст';
 stringgrid2.Cells[5,0]:='Рост';
 stringgrid2.Cells[6,0]:='Вес';
 stringgrid2.Visible:=false;
 button5.Enabled:=false;
 button6.Enabled:=false;
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
   for j:=0 to 6 do
    stringgrid1.Cells[j,i]:='';
 n:=0;
 while not eof(f) do
  begin
   inc(n);
   read(f,w);
   a[n]:=w;
  end;
 if n>0 then
  begin
   button5.Enabled:=true;
   button6.enabled:=true;
  end;
 stringgrid1.RowCount:=n+1;
 stringgrid1.FixedRows:=1;
 for i:=1 to n do vivod(i,i,stringgrid1);
 closefile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 SaveDialog1.Title:='Сохранить базу';
 SaveDialog1.DefaultExt:='.dat';
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
 button5.Enabled:=true;
 button6.Enabled:=true;
 stringgrid1.rowcount:=n+1;
 stringgrid1.fixedrows:=1;
 a[n].str:=edit1.Text;
 a[n].kom:=edit2.Text;
 a[n].fio:=edit3.Text;
 a[n].num:=strtoint(edit4.Text);
 a[n].let:=strtoint(edit5.Text);
 a[n].rost:=strtoint(edit6.Text);
 a[n].ves:=strtoint(edit7.Text);
 vivod(n,n,stringgrid1);
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 edit7.Text:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if n<>0 then
  for i:=1 to n do
   for j:=0 to 2 do
    stringgrid1.Cells[j,i]:='';
 n:=0;
 button5.Enabled:=false;
 button6.Enabled:=false;
 stringgrid1.FixedRows:=0;
 stringgrid1.rowcount:=1;
 stringgrid2.Visible:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
 var m:integer;
     s:string;
begin
 stringgrid2.Visible:=true;
 m:=0;
 s:=poisk;
 for i:=1 to n do
  if a[i].kom=s then
   begin
    inc(m);
    stringgrid2.RowCount:=m+1;
    vivod(m,i,stringgrid2);
   end;
end;

procedure TForm1.Button6Click(Sender: TObject);
 var m:integer;
     s:string;
begin
 SaveDialog1.Title:='Сохранить результат в файл';
 SaveDialog1.DefaultExt:='.txt';
 if savedialog1.Execute then
  begin
   assignfile(ft,savedialog1.filename);
   rewrite(ft);
  end
 else Exit;
 s:=poisk;
 writeln(ft,'     Самая молодая команда');
 writeln(ft,'   Страна  Команда       Ф.И.О.  Ном. Лет Рост Вес');
 for i:=1 to n do
  if a[i].kom=s then
   with a[i] do writeln(ft,str:10,kom:10,fio:15,num:5,let:4,rost:5,ves:4);
 closefile(ft);
end;

end.
