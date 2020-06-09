unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, Buttons;

type
  zap=record
    fam:string[10];
    adr:string[20];
    date:TDate;
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
    StringGrid2: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure filtr;
var ind:boolean;
begin
 m:=0;
 for i:=1 to n do
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

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Text:='';
 edit2.Text:='';
 stringgrid1.RowCount:=1;
 stringgrid1.FixedRows:=0;
 stringgrid2.RowCount:=2;
 stringgrid2.FixedRows:=1;
 stringgrid2.Visible:=false;
 stringgrid1.Cells[0,0]:='0';
 stringgrid1.Cells[1,0]:='Surname';
 stringgrid1.Cells[2,0]:='Address';
 stringgrid1.Cells[3,0]:='Date';
 stringgrid2.Cells[0,0]:='Surname';
 stringgrid2.Cells[1,0]:='Address';
 stringgrid2.Cells[2,0]:='Date';
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
   stringgrid1.Cells[1,i]:=a[i].adr;
   stringgrid1.Cells[2,i]:=datetostr(a[i].date);
  end;
 closefile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Savedialog1.Title:='Save into base';
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
 a[n].adr:=edit2.Text;
 a[n].date:=Datetimepicker2.Date;
 stringgrid1.Cells[0,n]:=inttostr(n);
 stringgrid1.Cells[1,n]:=edit1.Text;
 stringgrid1.Cells[2,n]:=edit2.Text;
 stringgrid1.Cells[3,n]:=datetostr(a[n].date);
 edit1.Text:='';
 edit2.Text:='';
 DateTimePicker2.date:=date;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 stringgrid2.Visible:=true;
 filtr;
 stringgrid2.RowCount:=M+1;
 for i:=1 to m do
  begin
   stringgrid2.Cells[0,i]:=inttostr(i);
   stringgrid2.Cells[1,i]:=b[i].fam;
   stringgrid2.Cells[2,i]:=b[i].adr;
   stringgrid2.Cells[3,i]:=datetostr(b[i].date);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 filtr;
 Savedialog1.Title:='Save into text file';
 Savedialog1.DefaultExt:='txt';
 if savedialog1.Execute then
  begin
   assignfile(ft,savedialog1.filename);
   rewrite(ft);
  end
 else Exit;
 writeln(ft,'List of customers');
 writeln(ft,'Surname Address');
 for i:=1 to m do writeln(ft,b[i].fam:10,b[i].adr:20);
 closefile(ft);
end;

end.
