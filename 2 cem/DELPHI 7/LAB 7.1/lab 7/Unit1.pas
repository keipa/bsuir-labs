unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, Unit2, Math;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    BitButton4: TBitBtn;
    BitButton3: TBitBtn;
    BitButton1: TBitBtn;
    BitButton2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitButton1Click(Sender: TObject);
    procedure BitButton2Click(Sender: TObject);
    procedure BitButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
   

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Stek: CStack;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  with Stringgrid1 do
    begin
      Cells[0,0]:='name'; Cells[1,0]:='znach';
      Cells[0,1]:='b';    Cells[1,1]:='2';
      Cells[0,2]:='x';    Cells[1,2]:='2';
      Cells[0,3]:='y';    Cells[1,3]:='9';
      Cells[0,4]:='c';    Cells[1,4]:='2';
      Cells[0,5]:='z';    Cells[1,5]:='2';
      Cells[0,6]:='d';    Cells[1,6]:='3';
      Cells[0,7]:='a';    Cells[1,7]:='1';
      Cells[0,8]:='e';    Cells[1,8]:='2';
    end;
  Edit1.Text:='b*((x-y/c)*(z^d+a))-e';
  Edit2.Clear;
  Edit3.Clear;
end;

procedure TForm1.BitButton2Click(Sender: TObject);
var
  i:byte;
  ch:char;
  strp:string;
begin
  strp:=Edit2.Text;
  for i:=1 to 8 do
    begin
      ch:=Stringgrid1.Cells[0,i][1];
      mszn[Ord(ch)]:=StrToFloat(Stringgrid1.Cells[1,i]);
    end;
  Edit3.Text:=FloatToStr(Stek.AV(strp));
end;

procedure TForm1.BitButton1Click(Sender: TObject);
var stri, strp: string;
begin
  stri:=Edit1.Text;
  Stek.OBP(stri,strp);
  Edit2.Text:=strp;
end;

procedure TForm1.BitButton3Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.clear;
  Edit3.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var b,x,y,c,z,d,a,e,k,znach:extended;
begin
  b:=2; x:=2; y:=9; c:=2; z:=2; d:=3; a:=1; e:=2;
  znach:=b*((x-y/c)*(z*d+a))-e-10;
  Edit3.Text:=FloatToStr(znach);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
edit3.Clear;
end;

end.
