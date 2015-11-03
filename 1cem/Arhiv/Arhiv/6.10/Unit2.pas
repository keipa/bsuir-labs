unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, biblio;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Edit4: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
 Edit2.Text:='0,5';
 Edit3.Text:='0,04';
 Edit4.Text:='0,0001';
 Memo1.Clear;
 Memo1.Lines.Add('Ğåçóëüòàòû ëàá.ğàá. ¹3 ãğ.712-502, Ëèòâèíîâà Î.Å.');
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b,h,x,s,eps:extended;
k:integer;
begin
 a:=StrToFloat(Edit1.Text);
 b:=StrToFloat(Edit2.Text);
 h:=Strtofloat(Edit3.text);
 eps:=StrTofloat(edit4.text);
 x:=a;
 repeat
 sum(x,eps,s,k);
 memo1.lines.add(floattostrf(x,fffixed,5,2)+
    '         '+floattostrf(s,fffixed,9,6)+
    '         '+floattostrf(y(x),fffixed,9,6)+
    '         '+floattostr(k));
    x:=x+h;
 until x>b+0.0000000001;
   end;
  end.
