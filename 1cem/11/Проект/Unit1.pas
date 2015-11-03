unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Unit2;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n:integer;
  r:extended;
  rec:TRec;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  RadioGroup1.ItemIndex:=0;
  Edit1.Clear; Edit2.Clear;
  Edit1.Text:='2';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  n:=StrToInt(Edit1.Text);
  if Odd(n) then ShowMessage('Необходимо ввести чётное n, n>=2')
            else
              begin
                case RadioGroup1.ItemIndex of
                0: r:=rec.FRecursion(n);
                1: r:=rec.FRecurent(n);
                end;
                Edit2.Text:=FloatToStr(r);
              end;
end;
end.
