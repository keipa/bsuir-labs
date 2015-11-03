unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Label7: TLabel;
    Edit5: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type razg=record
         gor:string[30];
         time:integer;
         tar:integer;
         nom:integer;
         end;

var
  f:file of razg;
  ft:textfile;
  w:razg;
  fname,fnamet:string;
  zak:boolean;
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear; memo2.Clear; memo3.Clear; memo4.Clear;
edit1.clear; edit2.clear; edit3.clear; edit4.clear;
button1.Enabled:=false; edit5.Clear;
memo5.Clear; memo6.Clear; memo7.clear;
label5.Caption:='';
label6.Caption:='';
label7.Caption:='';
zak:=false;
memo5.Hide;
memo6.Hide;
memo7.Hide;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
w.gor:=edit1.text;
w.time:=strtoint(edit2.text);
w.tar:=strtoint(edit3.text);
w.nom:=strtoint(edit4.text);
write(f,w);
memo1.lines.add(w.gor);
memo2.lines.add(inttostr(w.time));
memo3.lines.add(inttostr(w.tar));
memo4.lines.add(inttostr(w.nom));
edit1.clear; edit2.clear; edit3.clear; edit4.clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
SaveDialog1.Title:='Создать файл';
SaveDialog1.DefaultExt:='.dat';
 if SaveDialog1.Execute then
   begin
   fname:=SaveDialog1.FileName;
   AssignFile(f,fname);
   Rewrite(f);
   end;
 button1.Enabled:=true;
 zak:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
OpenDialog1.Title:='Открыть файл';
 if OpenDialog1.Execute then
    begin
    fname:=OpenDialog1.FileName;
    AssignFile(f,fname);
    Reset(f);
    zak:=true;
    end;
  memo1.clear; memo2.clear; memo3.clear; memo4.clear;
 while not eof(f) do
    begin
    read(f,w);
    memo1.lines.add(w.gor);
    memo2.lines.add(inttostr(w.time));
    memo3.lines.add(inttostr(w.tar));
    memo4.lines.add(inttostr(w.nom));
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
SaveDialog1.Title:='Сохранить в текстовом файле';
SaveDialog1.DefaultExt:='.txt';
if SaveDialog1.Execute then
     begin
     fnamet:=SaveDialog1.FileName;
     AssignFile(ft,fnamet);
     Rewrite(ft);
     end;
writeln(ft,' Информация о разговорах');
writeln(ft,'     Город  время  тариф     номер телефона ');
reset(f);
while not eof(f) do
      begin
      read(f,w);
        with w do
        writeln(ft,gor:10,time:6,tar:5,nom:15);
      end;
zak:=false;
closeFile(f);
closeFile(ft);
end;

procedure TForm1.Button5Click(Sender: TObject);
var k,m:integer;
begin
k:=0; m:=0;
label5.Caption:='общее время разговора';
label6.Caption:='сумма';
memo5.Show; memo6.Show; memo7.Show;
memo5.Clear; memo6.Clear; memo7.Clear; 
reset(f);
  repeat
  read(f,w);
   if w.gor=edit5.Text
   then
     begin
     k:=k+w.time;
     m:=m+w.time*w.tar;
     end;
   until eof(f);
   memo5.Lines.Add(edit5.Text);
   memo6.Lines.Add(inttostr(k));
   memo7.Lines.Add(inttostr(m));
   closefile(f);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
if zak then closefile(f);
end;

end.









