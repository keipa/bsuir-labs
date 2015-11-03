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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Memo9: TMemo;
    Memo10: TMemo;
    Memo11: TMemo;
    Memo12: TMemo;
    Memo13: TMemo;
    Memo14: TMemo;
    procedure clrall;
    procedure vivod(n,k:integer);
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

procedure TForm1.vivod(n,k:integer);
begin
 if k=1 then
  begin
   Memo1.lines.add(a[n].str);
   Memo2.lines.add(a[n].kom);
   Memo3.lines.add(a[n].fio);
   Memo4.lines.add(inttostr(a[n].num));
   Memo5.lines.add(inttostr(a[n].let));
   Memo6.lines.add(inttostr(a[n].rost));
   Memo7.lines.add(inttostr(a[n].ves));
  end
 else
  begin
   Memo8.lines.add(a[n].str);
   Memo9.lines.add(a[n].kom);
   Memo10.lines.add(a[n].fio);
   Memo11.lines.add(inttostr(a[n].num));
   Memo12.lines.add(inttostr(a[n].let));
   Memo13.lines.add(inttostr(a[n].rost));
   Memo14.lines.add(inttostr(a[n].ves));
  end;
end;

procedure TForm1.clrall;
begin
 Memo1.Clear;
 Memo2.Clear;
 Memo3.Clear;
 Memo4.Clear;
 Memo5.Clear;
 Memo6.Clear;
 Memo7.Clear;
 Memo8.Clear;
 Memo9.Clear;
 Memo10.Clear;
 Memo11.Clear;
 Memo12.Clear;
 Memo13.Clear;
 Memo14.Clear;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 edit4.Text:='';
 edit5.Text:='';
 edit6.Text:='';
 edit7.Text:='';
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
 clrall;
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
 clrall;
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
 for i:=1 to n do vivod(i,1);
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
 a[n].str:=edit1.Text;
 a[n].kom:=edit2.Text;
 a[n].fio:=edit3.Text;
 a[n].num:=strtoint(edit4.Text);
 a[n].let:=strtoint(edit5.Text);
 a[n].rost:=strtoint(edit6.Text);
 a[n].ves:=strtoint(edit7.Text);
 vivod(n,1);
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
 clrall;
 n:=0;
 button5.Enabled:=false;
 button6.Enabled:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
 var m:integer;
     s:string;
begin
 s:=poisk;
 for i:=1 to n do
  if a[i].kom=s then vivod(i,2);
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
