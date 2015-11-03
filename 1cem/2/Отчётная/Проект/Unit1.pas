unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Label4: TLabel;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='0,1';
Edit2.Text:='0,356';
Edit3.Text:='0,53';
Memo1.Clear;
RadioGroup1.ItemIndex:=0;
end;

procedure TForm1.Memo1Click(Sender: TObject);
var x,y,z,u,ma,mi,n:extended;
begin
 Memo1.Clear;
 x:=StrToFloat(Edit1.Text);
 y:=StrToFloat(Edit2.Text);
 z:=StrToFloat(Edit3.Text);
 Memo1.Lines.Add('Результат:');
 Memo1.Lines.Add('x='+FloatToStrF(x,ffFixed,8,4));
 Memo1.Lines.Add('y='+FloatToStrF(y,ffFixed,8,4));
 Memo1.Lines.Add('z='+FloatToStrF(z,ffFixed,8,4));
 case RadioGroup1.ItemIndex of
  0: u:=sinh(x);
  1: u:=sqr(x);
  2: u:=exp(x)
 end;
 if (u+y)<(y-z) then mi:=u+y else mi:=y-z;
 if u>y then ma:=u else ma:=y;
 n:=mi/ma;
 if CheckBox1.Checked then Memo1.Lines.Add('n='+IntToStr(Round(n)))
                      else Memo1.Lines.Add('n='+FloatToStrF(n,ffGeneral,8,2));
end;

end.
