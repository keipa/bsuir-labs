unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls;

type
  zap=record
    name:string[20];
    count_of_det:integer;
    factory_num:integer;
   end;
  zapmas=array[1..100] of zap;
  TForm1 = class(TForm)
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button5: TButton;
    Label8: TLabel;
    Button6: TButton;
    StringGrid1: TStringGrid;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit5: TEdit;
    Label10: TLabel;
    Button10: TButton;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);

    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,i,j:integer;
  a:zapmas;
  w:zap;
  f:file of zap;
  ft:textfile;

implementation

{$R *.dfm}

 function Poisk(x, l, r,n: integer): integer;
var
  c,i: Integer;

begin
   c:=(l+r) div 2;
   if l>r then exit;
  if (a[c].count_of_det = x)  then
              begin   Poisk:= c; Exit;    end
               else
                if A[c].count_of_det < x then
                             Begin  poisk:=poisk(x, l+1 , c-1, n+1);  end
                            else
                             Begin  poisk:= poisk(x, c+1 , r-1, n+1);end ;


  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear;
memo2.Clear;

stringgrid1.cells[1,0] :=('Наименование');
stringgrid1.cells[2,0] :=('Количество');
stringgrid1.cells[3,0] :=('Номер цеха');
label8.Visible:=False;

end;

procedure TForm1.Button4Click(Sender: TObject);
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
   stringgrid1.Cells[0,i]:=inttostr(i);
   stringgrid1.Cells[1,i]:=a[i].name;
   stringgrid1.Cells[2,i]:=inttostr(a[i].count_of_det);
   stringgrid1.Cells[3,i]:=inttostr(a[i].factory_num);
  end;
 closefile(f);
end;

procedure TForm1.Button3Click(Sender: TObject);
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

procedure TForm1.Button5Click(Sender: TObject);
begin
 label8.Visible:=True;

 inc(n);
 label8.caption:= 'Добавлена '+inttostr(n)+'-я запись в базу';
 stringgrid1.rowcount:=n+1;
 stringgrid1.fixedrows:=1;
 a[n].name:=edit2.Text;
 a[n].count_of_det:=strtoint(edit3.Text);
 a[n].factory_num:=strtoint(edit4.Text);
 stringgrid1.Cells[0,n]:=inttostr(n);
 stringgrid1.Cells[1,n]:=edit2.Text;
 stringgrid1.Cells[2,n]:=edit3.Text;
 stringgrid1.Cells[3,n]:=edit4.Text;
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';

end;

procedure TForm1.Button8Click(Sender: TObject);


begin

 for i:=1 to n do
 begin
 stringgrid1.Cells[0,i]:='';
 stringgrid1.Cells[1,i]:='';
 stringgrid1.Cells[2,i]:='';
 stringgrid1.Cells[3,i]:='';
end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
h,j,m:integer;
r:zap;
c:integer;
begin
  c:=0;
  for i:=1 to n do begin
  m:=i;
  for j:=i+1 to n do
  if a[j].count_of_det>a[m].count_of_det then m:=j;
  r:=a[m]; a[m]:=a[i]; a[i]:=r;
  inc(c);
  end;
 h:=1;
 for i:=1 to n do
 begin
 stringgrid1.Cells[0,i]:='';
 stringgrid1.Cells[1,i]:='';
 stringgrid1.Cells[2,i]:='';
 stringgrid1.Cells[3,i]:='';
end;
 for i:=1 to n do
 begin

   stringgrid1.Cells[0,h]:=inttostr(i);
   stringgrid1.Cells[1,h]:=a[i].name;
   stringgrid1.Cells[2,h]:=inttostr(a[i].count_of_det);
   stringgrid1.Cells[3,h]:=inttostr(a[i].factory_num);
   inc(h)
   end;
 end;




procedure TForm1.Button1Click(Sender: TObject);
var
h:integer;
begin
h:=1;
 for i:=1 to n do
 begin
 if a[i].count_of_det = strtoint(edit1.Text) then
  begin
  memo1.Lines.add(inttostr(h)+'. '+a[i].name+': Количество '+ inttostr(a[i].count_of_det)+' из цеха № '+inttostr(a[i].factory_num));
  inc(h)
  end;
end;
end;


procedure TForm1.Button9Click(Sender: TObject);
var
h,j,m:integer;
r:zap;
c:integer;
begin
 c:=0;
 h:=1;
 for i:=1 to n do
 begin
 stringgrid1.Cells[0,i]:='';
 stringgrid1.Cells[1,i]:='';
 stringgrid1.Cells[2,i]:='';
 stringgrid1.Cells[3,i]:='';
end;
 for i:=1 to n do
 begin
 inc(c);
 if a[i].count_of_det = strtoint(edit5.Text) then

  begin
   stringgrid1.Cells[0,h]:=inttostr(i);
   stringgrid1.Cells[1,h]:=a[i].name;
   stringgrid1.Cells[2,h]:=inttostr(a[i].count_of_det);
   stringgrid1.Cells[3,h]:=inttostr(a[i].factory_num);
   inc(h)
   end;
 end;
 memo2.Lines.Add(inttostr(c));
end;

procedure TForm1.Button10Click(Sender: TObject);
var
h:integer;
c:integer;
i:integer;
begin
 for i:=1 to n do
 begin
 stringgrid1.Cells[0,i]:='';
 stringgrid1.Cells[1,i]:='';
 stringgrid1.Cells[2,i]:='';
 stringgrid1.Cells[3,i]:='';
 memo2.clear;
 memo2.Lines.add('3');
end;
c:=0;
h:=Poisk(strtoint(edit5.Text), 0, n,c);
   stringgrid1.Cells[0,1]:=inttostr(h);
   stringgrid1.Cells[1,1]:=a[h].name;
   stringgrid1.Cells[2,1]:=inttostr(a[h].count_of_det);
   stringgrid1.Cells[3,1]:=inttostr(a[h].factory_num);
end;

end.
