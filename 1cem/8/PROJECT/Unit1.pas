unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileFunc;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button1: TButton;
    SaveDialog2: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type
  TInfo = record
  PN:string[20];
  Npl, Tm, DoW:word;
  end;
var
  LInf,SInf: file of TInfo;
  TInf: textfile;
  Trains: array[1..15] of TInfo;
  num: integer;
  FileNameL, FileNameS: string;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Pclear(Edit1,Edit2,Edit3,Edit4,Memo1,Memo2);
num:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  begin
    FileNameL:=SaveDialog1.FileName;
    AssignFile(LInf,FileNameL);
    Rewrite(LInf);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  num:=num+1;
  with Trains[num] do
    begin
      DoW:=StrToInt(Edit1.Text);
      PN:=Edit2.Text;
      Tm:=StrToInt(Edit3.Text);
      Npl:=StrToInt(Edit4.Text);
      Memo2.Lines.Add('№'+IntToStr(num)+', день отправления: '+IntToStr(DoW)+', в '+PN+' отправляется в '+IntToStr(Tm)+' часов. Кол-во свободных мест: '+IntToStr(Npl));
    end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  d, t, nom, i: integer;
  p: string;
begin
  d:=StrToInt(Edit1.Text);
  p:=Edit2.Text;
  t:=StrToInt(Edit3.Text);
  nom:=StrToInt(Edit4.Text);
  Memo1.Clear;
  for i:=1 to 15 do
    if Trains[i].DoW=d then
      if Trains[i].PN=p then
        if Trains[i].Tm>=t then
          if Trains[i].Npl>=nom then
            Memo1.Lines.Add('Поезд '+IntToStr(i)+' отправляется в '+IntToStr(Trains[i].Tm)+' часов');
    if(Trains[i].Dow<>d) and (Trains[i].PN<>p) and (Trains[i].Tm<t) and (Trains[i].Npl<nom) then Memo1.Lines.Add('Результатов не найдено');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:word;
begin
  if SaveDialog1.Execute then
    begin
      FileNameS:=SaveDialog1.FileName;
      AssignFile(SInf,FileNameS);
      Rewrite(SInf);
    end;
  for i:=1 to num do
    write(SInf,trains[i]);
  CloseFile(SInf);
  if SaveDialog2.Execute then
    begin
      FileNameS:=SaveDialog2.FileName;
      AssignFile(TInf,FileNameS);
      Rewrite(TInf);
    end;
  for i:=1 to num do
    with Trains[i] do writeln(TInf,i:4,'.',' День недели: ',DoW,', Пункт назначения: ',PN,', Время отправления: ',Tm,', Кол-во мест: ',Npl);
  CloseFile(TInf);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  begin
    FileNameL:=OpenDialog1.FileName;
    AssignFile(LInf,FileNameL);
    Reset(LInf);
  end;
  num:=0;
  while not eof(LInf) do
    begin
      Inc(num);
      Read(LInf,Trains[num]);
      with Trains[num] do
         Memo2.Lines.Add('№'+IntToStr(num)+', день отправления: '+IntToStr(Trains[num].DoW)+', в '+Trains[num].PN+' отправляется в '+IntToStr(Trains[num].Tm)+' часов. Кол-во свободных мест: '+IntToStr(Trains[num].Npl));
    end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
CloseFile(LInf);
end;

end.
