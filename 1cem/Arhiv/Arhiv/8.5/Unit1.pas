unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls;

type
  zap=record
    fam:string[15];
    chas:integer;
    tar:integer;
    sum:integer;
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
    StringGrid2: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    Edit3: TEdit;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid2.Visible:=false;
 stringgrid1.Cells[0,0]:='Фамилия';
 stringgrid1.Cells[1,0]:='Кол-во часов';
 stringgrid1.Cells[2,0]:='Тариф';
 stringgrid2.Cells[0,0]:='Фамилия';
 stringgrid2.Cells[1,0]:='Кол-во часов';
 stringgrid2.Cells[2,0]:='Тариф';
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
 for i:=1 to n do
  begin
   stringgrid1.Cells[0,i]:=a[i].fam;
   stringgrid1.Cells[1,i]:=inttostr(a[i].chas);
   stringgrid1.Cells[2,i]:=inttostr(a[i].tar);
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
 a[n].chas:=strtoint(edit2.Text);
 a[n].tar:=strtoint(edit3.Text);
 stringgrid1.Cells[0,n]:=edit1.Text;
 stringgrid1.Cells[1,n]:=edit2.Text;
 stringgrid1.Cells[2,n]:=edit3.Text;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if n<>0 then
  for i:=1 to n do
   for j:=0 to 2 do
    begin
     stringgrid1.Cells[j,i]:='';
     stringgrid2.Cells[j,i]:='';
    end;
 n:=0;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 stringgrid1.FixedRows:=0;
 stringgrid1.rowcount:=1;
 stringgrid2.FixedRows:=1;
 stringgrid2.rowcount:=2;
 stringgrid2.Visible:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 stringgrid2.Visible:=true;
 stringgrid2.RowCount:=n+1;
 for i:=1 to n do
  begin
   stringgrid2.Cells[0,i]:=a[i].fam;
   a[i].sum:=round(0.88*a[i].chas*a[i].tar);
   if a[i].chas>144 then a[i].sum:=a[i].sum*2;
   stringgrid2.Cells[1,i]:=inttostr(a[i].sum);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 Savedialog1.Title:='Сохранить в текстовый файл';
 Savedialog1.DefaultExt:='txt';
 if savedialog1.Execute then
  begin
   assignfile(ft,savedialog1.filename);
   rewrite(ft);
  end
 else Exit;
 for i:=1 to n do
  begin
   a[i].sum:=round(0.88*a[i].chas*a[i].tar);
   if a[i].chas>144 then a[i].sum:=a[i].sum*2;
  end;
 writeln(ft,'        Размер заработной платы');
 writeln(ft,'       Фамилия                Сумма');
 for i:=1 to n do writeln(ft,a[i].fam:15,a[i].sum:8);
 closefile(ft);
end;

end.
