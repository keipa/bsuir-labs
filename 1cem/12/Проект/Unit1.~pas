unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, unit2;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Metod: TMetod;
  ocm: Extended;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit2.Text:='10';
  Memo1.Clear;
  StringGrid1.Cells[0,0]:='Вес';
  StringGrid1.Cells[0,1]:='22';
  StringGrid1.Cells[0,2]:='11';
  StringGrid1.Cells[0,3]:='12';
  StringGrid1.Cells[0,4]:='13';
  StringGrid1.Cells[0,5]:='14';
  StringGrid1.Cells[0,6]:='15';
  StringGrid1.Cells[0,7]:='16';
  StringGrid1.Cells[0,8]:='17';
  StringGrid1.Cells[0,9]:='18';
  StringGrid1.Cells[0,10]:='19';
  StringGrid1.Cells[1,0]:='Цена';
  StringGrid1.Cells[1,1]:='18';
  StringGrid1.Cells[1,2]:='20';
  StringGrid1.Cells[1,3]:='17';
  StringGrid1.Cells[1,4]:='19';
  StringGrid1.Cells[1,5]:='16';
  StringGrid1.Cells[1,6]:='21';
  StringGrid1.Cells[1,7]:='27';
  StringGrid1.Cells[1,8]:='23';
  StringGrid1.Cells[1,9]:='25';
  StringGrid1.Cells[1,10]:='24';
  RadioGroup1.ItemIndex:=0; Edit1.Text:='50';
  Metod:=TMetod.Create;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Resh.Free;
Close();
end;

procedure TForm1.Button2Click(Sender: TObject);
Var I:integer;
begin
Memo1.Clear;
With Resh do begin
 n:=strToInt(Edit2.Text); ocm:=0;
 	for i:=1 to n do begin
 		a[i].w:=StrToInt(StringGrid1.Cells[0,i]);
 		a[i].c:=StrToInt(StringGrid1.Cells[1,i]);
 		ocm:=ocm+a[i].c;
end;
	  Wmax:=StrToInt(Edit1.Text);
	  Cmax:=0; S:=[]; Sopt:=[];
   case RadioGroup1.itemindex of
   0:begin ocm:=0; VMPP(1,0,ocm); end;
   1:VMVG(1,0,ocm);
   2:VMMS;
   3:VMMW;
   4:VMSV;
   5:VMR;
   end;
Memo1.Lines.Add('Оптимальный вариант');
Memo1.Lines.Add(' i       w      c');
	  for i:=1 to n do
	    if i in Sopt then
Memo1.Lines.Add(IntToStr(i)+'  '+FloatToStrF(a[i].w,ffFixed,8,3)+'  '+FloatToStrF (a[i].c,ffFixed,8,3));
Memo1.Lines.Add('Cmax='+FloatToStrF (Cmax,ffFixed,8,3)+'  Wmax='+FloatToStrF (Wmax,ffFixed,8,3));
                       End;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var i:Integer;
begin
resh.n:=StrToInt(Edit2.Text);
StringGrid1.RowCount:=resh.n+1;
for i:=1 to resh.n do
begin
stringGrid1.Cells[0,i]:=inttostr(Random(10)+5);
StringGrid1.Cells[1,i]:=inttostr(Random(15)+5);
end;
end;

end.
