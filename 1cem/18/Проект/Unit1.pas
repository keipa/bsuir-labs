unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit2, ComCtrls, StdCtrls, Buttons, Grids, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TreeView1: TTreeView;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tr:Ttree;
  N:integer;
  b:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=10;
  Edit1.Text:=IntToStr(N);
  Memo1.Clear;
  with StringGrid1 do
    begin
      ColCount:=2;
      RowCount:=N+1;
      Cells[0,0]:='Ф.И.О.';
      Cells[1,0]:='Номер';
      Cells[0,1]:='Иванов А.А.';    Cells[1,1]:='100005';
      Cells[0,2]:='Петров С.И.';	  Cells[1,2]:='100002';
      Cells[0,3]:='Сидоров К.М.';   Cells[1,3]:='100004';
      Cells[0,4]:='Васильев М.К.';  Cells[1,4]:='100001';
      Cells[0,5]:='Смирнов В.К.';   Cells[1,5]:='100007';
      Cells[0,6]:='Мишин Т.В.';     Cells[1,6]:='100006';
      Cells[0,7]:='Долин А.К.';	    Cells[1,7]:='100008';
      Cells[0,8]:='Катаев А.М.';    Cells[1,8]:='100000';
      Cells[0,9]:='Рубан В.В.';	    Cells[1,9]:='100009';
      Cells[0,10]:='Шидлов А.С.';   Cells[1,10]:='100012';
    end;
  tr:=Ttree.Create;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  N:=StrToInt(Edit1.Text);
  StringGrid1.RowCount:=N+1;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var i:integer;
    a:TMs;
begin
  Memo1.Clear;
  TreeView1.Items.Clear;
  for i:=1 to N do
    with a[i] do
      begin
        s:=StringGrid1.Cells[0,i];
        key:=StrToInt(StringGrid1.Cells[1,i]);
      end;
  with tr do
    begin
      if b then
        Delete(proot);
      Make1B(a,N);
      View;
    end;
  b:=true;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Memo1.Clear;
  tr.WrtB;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  tr.free;
  Memo1.Clear;
  TreeView1.Items.Clear;
  b:=false;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var i,j:integer;
    a:TMs;
    t:TInf;
begin
  for i:=1 to N do
    with a[i] do
      begin
        s:=StringGrid1.Cells[0,i];
        key:=StrToInt(StringGrid1.Cells[1,i]);
      end;
  for i:=1 to N-1 do
    for j:=i+1 to N do
      if a[i].key>a[j].key then
        begin
          t:=a[i];
          a[i]:=a[j];
          a[j]:=t;
        end;
  Memo1.Clear;
  TreeView1.Items.Clear;
  with tr do
    begin
      if b then
        Delete(proot);
      BLns(a,N);
      View;
      WrtB;
    end;
  b:=true;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var x:TInf;
    q:Tkey;
begin
  q:=StrToInt(LabeledEdit1.Text);
  x:=tr.Poisk(q);
  Memo1.Clear;
  Memo1.Lines.Add(x.s+' '+IntToStr(x.key));
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var x:TInf;
    q:TKey;
begin
  q:=StrToInt(LabeledEdit1.Text);
  x:=tr.Poisk(q);
  tr.Delk(x.key);
  Memo1.Clear;
  TreeView1.Items.Clear;
  tr.View;
  tr.WrtB;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  sredn:=Tr.Srkey(Tr.proot);
  Memo1.Clear;
  Memo1.Lines.Add('Среднее значение ключей:'+FloatToStr(sredn));
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
var x:TInf;
    y:TKey;
begin
  y:=Tr.FindNear(Tr.proot);
  x:=Tr.Poisk(y);
  Memo1.Clear;
  Memo1.Lines.Add(x.s+' '+IntToStr(x.key))
end;

end.
