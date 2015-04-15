unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Unit2;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BitBtn7: TBitBtn;
    Label4: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);

    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SaS: TSaS;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear; Edit2.Clear; Edit3.Clear; Edit4.Clear;
  Memo1.Clear;
  SaS:=TSaS.Create;
  num:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SaS.PCreate(SaveDialog1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SaS.POpen(OpenDialog1, Memo1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SaS.PSave (SaveDialog1, SaveDialog2);
end;



procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  SaS.PLineSearch(Edit4,Memo1);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var c:TInfo; i:byte;
begin
  SaS.PRead1(c);
  Memo1.Clear;
  for i:=1 to num do
    with SaS.bd[i] do
      Memo1.Lines.Add(IntToStr(i)+') Цех №'+Nc+', Количество: '+kol+', Название: '+nazv);
end;



procedure TForm1.btn1Click(Sender: TObject);
begin
SaS.PAdd(Edit1,Edit2,Edit3,Memo1);
end;

procedure TForm1.btn2Click(Sender: TObject);
var c:TInfo; i:byte;
begin
  SaS.PRead1(c);
  Memo1.Clear;
  for i:=1 to num do
    with SaS.bd[i] do
      Memo1.Lines.Add(IntToStr(i)+') Цех №'+Nc+', Количество: '+kol+', Название: '+nazv);
end;
procedure TForm1.btn3Click(Sender: TObject);
begin
  SaS.PLineSearch(Edit4,Memo1);
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
SaS.PPrChoice(Memo1);
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
Memo1.Clear;
  SaS.PDSearch(Edit4,Memo1);
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
 SaS.PQuickSort(Memo1);
end;

end.
