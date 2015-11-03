unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MathFunction, Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  xn,xk,e:extended;
  m:integer;
implementation

{$R *.dfm}

function sx(x:extended):extended;
  var a,n,s:extended;
      k:integer;
  begin
    k:=-1;
    a:=1;
    n:=0;
    s:=1;
  try
    while (abs(a)>e) do
      begin
        n:=n+1;
        a:=-a*sqr(2*x)/(2*n*(2*n-1));
        s:=s+a;
      end;
    Result:=s;
  except
    on EInvalidOp do
      k:=MessageDlg('Neprav. op. s plav. tochkoi. '+' Continue?',mtError,[mbYes,mbNo],0);
    on EOverFlow do
      k:=MessageDlg('Perepolnenie. '+' Continue?',mtError,[mbYes,mbNo],0);
    else
      k:=MessageDlg('Neizvestnaya oshibka  '+' Continue?',mtError,[mbYes,mbNo],0);
    end;
    case k of
    mrYes: Result:=0;
    mrNo: Halt(1);
    end;
  end;
function yx(x:extended):extended;
  begin
   Result:=2*(sqr(cos(x))-1);;
  end;
   
procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  RadioGroup1.ItemIndex:=0;
  Edit1.Text:='0,1';
  Edit2.Text:='1';
  Edit3.Text:='9';
  Edit4.Text:='0,0001';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.Add('Results:');
  xn:=StrToFloat(Edit1.Text);
  Memo1.Lines.Add(' xn='+FloatToStrF(xn,ffFixed,6,2));
  xk:=StrToFloat(Edit2.Text);
  Memo1.Lines.Add(' xk='+FloatToStrF(xk,ffFixed,6,2));
  m:=StrToInt(Edit3.Text);
  Memo1.Lines.Add('m='+IntToStr(m));
  e:=StrToFloat(Edit4.Text);
  Memo1.Lines.Add(' e='+FloatToStrF(e,ffFixed,8,5));
  case RadioGroup1.ItemIndex of
  0: begin
      Memo1.Lines.Add('Raschet S(x)');
      Table(sx,xn,xk,m,Memo1);
     end;
  1: begin
      Memo1.Lines.Add('Raschet Y(x)');
      Table(yx,xn,xk,m,Memo1);
     end;
end;
end;

end.
