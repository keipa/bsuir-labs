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
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject); // Создать
begin
  SaS.PCreate(SaveDialog1);
end;

procedure TForm1.Button2Click(Sender: TObject); // Открыть
begin
  SaS.POpen(OpenDialog1, Memo1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SaS.PSave (SaveDialog1, SaveDialog2);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  SaS.PAdd(Edit1,Edit2,Edit3,Edit4,Memo1);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  SaS.PLineSearch(Edit1,Memo1);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  SaS.PPrChoice(Memo1);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  SaS.PQuickSort(Memo1);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Memo1.Clear;
  SaS.PDSearch(Edit1,Memo1);
end;

end.
