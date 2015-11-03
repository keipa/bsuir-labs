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
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
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

type stud=record 
      fam:string[20];
      oc:array[1..3] of byte;
      end;

var
 Form1: TForm1;
 f:file of stud;
 ft:textfile;
 w:stud;
 fname,fnamet:string;
 zak:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 memo1.Clear; memo2.Clear; memo3.Clear; memo4.Clear;
 edit1.clear; edit2.clear; edit3.clear; edit4.clear;
 button1.Enabled:=false;
 label5.Caption:='';
 zak:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 w.fam:=edit1.text;
 w.oc[1]:=strtoint(edit2.text);
 w.oc[2]:=strtoint(edit3.text);
 w.oc[3]:=strtoint(edit4.text);
 write(f,w);
 memo1.lines.add(w.fam);
 memo2.lines.add(inttostr(w.oc[1]));
 memo3.lines.add(inttostr(w.oc[2]));
 memo4.lines.add(inttostr(w.oc[3]));
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
 label5.Caption:='     Общий список';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 OpenDialog1.Title:='Открыть файл';
 if OpenDialog1.Execute then
  begin
   fname:=OpenDialog1.FileName;
   AssignFile(f,fname);
   Reset(f);
  end;
 memo1.clear; memo2.clear; memo3.clear; memo4.clear;
 while not eof(f) do
  begin
   read(f,w);
   memo1.lines.add(w.fam);
   memo2.lines.add(inttostr(w.oc[1]));
   memo3.lines.add(inttostr(w.oc[2]));
   memo4.lines.add(inttostr(w.oc[3]));
  end;
 closeFile(f);
 label5.Caption:='     Общий список';
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
 writeln(ft,'       Общий список студентов');
 writeln(ft,'   Фамилия Физика Математика Химия ');
 reset(f);
 while not eof(f) do
  begin
   read(f,w);
   with w do
    writeln(ft,fam:10,oc[1]:6,oc[2]:10,oc[3]:9);
  end;
 closeFile(f);
 closeFile(ft);
end;

procedure TForm1.Button5Click(Sender: TObject);
 var k,m:integer;
begin
 memo1.clear; memo2.clear; memo3.clear; memo4.clear;
 reset(f);
 while not eof(f) do
  begin
   read(f,w);
   m:=0;
   for k:=1 to 3 do
    if w.oc[k]=4 then m:=1;
   if m=0 then
    begin
     memo1.lines.add(w.fam);
     memo2.lines.add(inttostr(w.oc[1]));
     memo3.lines.add(inttostr(w.oc[2]));
     memo4.lines.add(inttostr(w.oc[3]));
    end;
  end;
 closeFile(f);
 label5.Caption:='Список студентов без четверок';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 if zak then closeFile(f);
end;

end.
