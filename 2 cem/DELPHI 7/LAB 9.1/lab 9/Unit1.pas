unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Unit2;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Memo2: TMemo;
    Memo3: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,i:integer; h1:th; r1:tr;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var inf:tinf;
begin
  n:=StrToInt(Edit1.Text);
  for i:=0 to n do begin
   inf.Fio:=StringGrid1.Cells[0,i];
   inf.key:=StrToInt(StringGrid1.Cells[1,i]);
   H1.Add(inf);
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
StringGrid1.RowCount:=StrToInt(Edit1.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Memo1.Clear; Edit1.Text:='7'; Edit2.Clear; Edit3.Clear; Memo2.Clear;
Memo3.Clear; h1:=th.create(StrToInt(Edit1.Text));
  with StringGrid1 do begin
      Cells[0,0]:='Иванов А.А.';    Cells[1,0]:='-50';
      Cells[0,1]:='Петров С.И.';	  Cells[1,1]:='50';
      Cells[0,2]:='Сидоров К.М.';   Cells[1,2]:='-49';
      Cells[0,3]:='Васильев М.К.';  Cells[1,3]:='18';
      Cells[0,4]:='Смирнов В.К.';   Cells[1,4]:='6';
      Cells[0,5]:='Мишин Т.В.';     Cells[1,5]:='3';
      Cells[0,6]:='Долин А.К.';	    Cells[1,6]:='-8';
      Cells[0,7]:='Катаев А.М.';    Cells[1,7]:='0';
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var inf:tinf;
begin
    Inf.Fio:=Edit2.Text;
    Inf.key:=StrToInt(Edit3.Text);
    H1.Add(inf);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Memo1.Clear; h1.Print(memo1,h);
end;

procedure TForm1.Button6Click(Sender: TObject);
var key:tkey; inf:tinf;
begin
    key:=StrToInt(Edit3.Text);H1.Read(key,Inf);
    Memo1.Clear; Memo1.Lines.Add(Inf.Fio);
end;

procedure TForm1.Button5Click(Sender: TObject);
var key:tkey; inf:tinf;
begin
    key:=StrToInt(Edit3.Text); H1.Red(key,Inf);
    Memo1.Clear; Memo1.Lines.Add(Inf.Fio);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
StringGrid1.rowcount:=H1.n; H1.Free(StringGrid1);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  r1.po; Memo2.Clear; Memo3.Clear; h1.Print(Memo2,hp); h1.Print(Memo3,ho);
end;
end.
