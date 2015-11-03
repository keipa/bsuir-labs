unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BitBtn1: TBitBtn;
    Button5: TButton;
    Label7: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit6: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Type stud=record
        fam,adr:string[20];
        oc:array[1..3] of byte;
        srb:extended;
        end;
var
  Form1: TForm1;
  f:file of stud;
  ft:textfile;
  w:stud;
  fname,fnamet:string;
  s:string;
  a:array [1..100]  of stud;
  n,i:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear; memo2.Clear; memo3.Clear; memo4.Clear;
memo5.Clear;
edit1.Clear; edit2.Clear; edit3.Clear;
edit4.Clear; edit5.Clear;
button1.Enabled:= false;
label7.Caption:='';
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
w.fam:=edit1.Text;
w.adr:=edit2.Text;
w.oc[1]:=strtoint(edit3.text);
w.oc[2]:=strtoint(edit4.text);
w.oc[3]:=strtoint(edit5.text);
write(f,w);
memo1.Lines.Add(w.fam);
memo2.Lines.Add(w.adr);
memo3.lines.add(inttostr(w.oc[1]));
memo4.lines.add(inttostr(w.oc[2]));
memo5.lines.add(inttostr(w.oc[3]));
edit1.Clear; edit2.Clear; edit3.Clear;
edit4.Clear; edit5.Clear;
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
  label7.Caption:='        Общий список'
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  OpenDialog1.Title:='Открыть файл';
  if OpenDialog1.Execute then
    begin
      fname:=OpenDialog1.Filename;
      AssignFile(f,fname);
      Reset(f);
    end;
  memo1.clear;  memo2.clear;  memo3.clear;
  memo4.clear;  memo5.clear;
    While not  eof(f) do
    begin
    read(f,w);
    memo1.lines.add(w.fam);
    memo2.lines.add(w.adr);
    memo3.lines.add(inttostr(w.oc[1]));
    memo4.lines.add(inttostr(w.oc[2]));
    memo5.lines.add(inttostr(w.oc[3]));
    end;
  CloseFile(f);
  label7.Caption:='        Общий список';
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
  writeln(ft,'      Общий список студентов');
  writeln(ft,'  Фамилия  Физика  Математика   НГИГ  ');
  reset(f);
while not eof(f) do
    begin
    read(f,w);
    with w do
        writeln(ft,fam:10,adr:10,oc[1]:6,oc[2]:10,oc[3]:9);
    end;
closeFile(f);
closeFile(ft);
end;

procedure TForm1.Button5Click(Sender: TObject);
  var r,m,k,n,kol:integer;

  begin
 memo1.clear; memo2.clear; memo3.clear; memo4.clear;
 memo5.clear;
 reset(f);
 edit6.text:='0';
 n:=0;
          while not eof(f) do            //создаем массив минских чуваков
            begin
             read(f,w);
             if w.adr='Минск' then
              begin
               inc(n);
               a[n]:=w;
              end;
            end;


                for i:=1 to n-1 do       //сортируем их по алфавиту
                     for r:=1 to n-i do
                       if a[r].fam>a[r+1].fam then
                          begin
                                w:=a[r]; a[r]:=a[r+1];
                                a[r+1]:=w;
                          end;



     for i:=1 to n do    //выводим только тех кто учился а не жувал крыжовник, хлопая ушами
     begin
     a[i].srb:=0;
        for  k:=1 to 3 do a[i].srb:=a[i].srb+a[i].oc[k];
            a[i].srb:=a[i].srb/3;
      if a[i].srb>=4.5  then
     begin
      memo1.Lines.Add(a[i].fam);
      memo2.Lines.Add(a[i].adr);
      memo3.lines.add(inttostr(a[i].oc[1]));
      memo4.lines.add(inttostr(a[i].oc[2]));
      memo5.lines.add(inttostr(a[i].oc[3]));
      Edit6.Text:=IntToStr(strtoint(edit6.Text)+1);
     end;
     end;
     CloseFile(f);
      end;
      end.


