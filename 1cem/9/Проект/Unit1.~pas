unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, UFormule, MathFunction, Clipbrd,
  TeEngine, Series, TeeProcs, Chart, MathGraph;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Image1: TImage;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    RadioGroup1: TRadioGroup;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TabSheet4: TTabSheet;
    Button3: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    BitBtn1: TBitBtn;
    TabSheet5: TTabSheet;
    Image2: TImage;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
var
  R,x1,x2,y1,y2,x31,x32,y31,y32,x41,x42,y41,y42,x33,y33,x43,y43,ysc,xsc:extended;
  y0, xmax, ymax, xmin, ymin, oxmax, oymax, oxmin, oymin:integer;
  xn,xk,e:extended;
  m:integer;
  f:fn;

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
Edit1.Text:='30';
Edit2.Text:='20';
Edit3.Text:='20';
Edit4.Text:='30';
Memo1.Clear;
RadioGroup1.ItemIndex:=0;
Edit5.Text:='0,1';
Edit6.Text:='1';
Edit7.Text:='9';
Edit8.Text:='0,0001';
Edit9.Text:='0';
Edit10.Text:='2';
Edit11.Text:='-2';
Edit12.Text:='2';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture:=nil;
  x1:=StrToFloat(Edit1.Text);
  y1:=StrToFloat(Edit2.Text);
  x2:=StrToFloat(Edit3.Text);
  y2:=StrToFloat(Edit4.Text);
  if x2<x1 then
    begin
      R:=x2;
      x2:=x1;
      x1:=R;
    end;
  if x2<=(Image1.Width/2) then
    begin
      x1:=Image1.Width/2 - x1;
      x2:=Image1.Width/2 + x2;
    end;
  if (y2<y1) and (y1<(Image1.Height/2)) then
   begin
     y1:=Image1.Height/2 + y1;
     y2:=Image1.Height/2 - y2;
   end;
  if (y2>y1) and (y2<(Image1.Height/2)) then
    begin
      y1:=Image1.Height/2 - y1;
      y2:=Image1.Height/2 + y2;
    end;
  if x2>x1 then
    if y2<y1 then
      begin
        x31:=FSecond(x2,y2,y1);
        x32:=FFirst(x2,y2,y1);
        x41:=FSecond(x1,y2,y1);
        x42:=FFirst(x1,y2,y1);
        y31:=FFirst(y2,x2,x1);
        y32:=FSecond(y2,x2,x1);
        y41:=FFirst(y1,x2,x1);
        y42:=FSecond(y1,x2,x1);
        xmax:=Round(x31);
        ymax:=Round(y41);
        xmin:=Round(x42);
        ymin:=Round(y32);
      end;

  if x2>x1 then
    if y2>y1 then
      begin
        x31:=FFirst(x2,y1,y2);
        x32:=FSecond(x2,y1,y2);
        x41:=FFirst(x1,y1,y2);
        x42:=FSecond(x1,y1,y2);
        y31:=FFirst(y2,x2,x1);
        y32:=FSecond(y2,x2,x1);
        y41:=FFirst(y1,x2,x1);
        y42:=FSecond(y1,x2,x1);
        xmax:=Round(x32);
        ymax:=Round(y31);
        xmin:=Round(x41);
        ymin:=Round(y42);
      end;
  x33:=FThird(x31,x1);
  x43:=FThird(x42,x2);
  y33:=FThird(y31,y1);
  y43:=FThird(y42,y2);

  ysc:=(2*Image1.Height)/(3*(ymax-ymin));
  xsc:=(2*Image1.Width)/(3*(xmax-xmin));
  if (xsc>ysc) and (xsc<=Image1.Width) then R:=ysc
    else R:=xsc;

  x1:=x1*R;
  x2:=x2*R;
  x31:=x31*R;
  x32:=x32*R;
  x41:=x41*R;
  x42:=x42*R;
  x33:=x33*R;
  x43:=x43*R;
  y1:=y1*R;
  y2:=y2*R;
  y31:=y31*R;
  y32:=y32*R;
  y41:=y41*R;
  y42:=y42*R;
  y33:=y33*R;
  y43:=y43*R;

  with  Image1.Canvas do
    begin
     MoveTo(Round(x1),Round(y1));
     LineTo(Round(x2),Round(y2));
     LineTo(Round(x31),Round(y31));
     LineTo(Round(x41),Round(y41));
     LineTo(Round(x1),Round(y1));
     MoveTo(Round(x1),Round(y1));
     LineTo(Round(x42),Round(y42));
     LineTo(Round(x32),Round(y32));
     LineTo(Round(x2),Round(y2));
     MoveTo(Round(x1),Round(y1));
     LineTo(Round(x43),Round(y43));
     LineTo(Round(x2),Round(y2));
     LineTo(Round(x33),Round(y33));
     LineTo(Round(x1),Round(y1));
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ClipBoard.Assign(Image1.Picture);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Image2.Picture:=Nil;
  Memo1.Clear;
  Memo1.Lines.Add('Results:');
  xn:=StrToFloat(Edit5.Text);
  Memo1.Lines.Add(' xn='+FloatToStrF(xn,ffFixed,6,2));
  xk:=StrToFloat(Edit6.Text);
  Memo1.Lines.Add(' xk='+FloatToStrF(xk,ffFixed,6,2));
  m:=StrToInt(Edit7.Text);
  Memo1.Lines.Add('m='+IntToStr(m));
  e:=StrToFloat(Edit8.Text);
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
  oxmin:=StrToInt(Edit9.Text);
  oxmax:=StrToInt(Edit10.Text);
  oymin:=StrToInt(Edit11.Text);
  oymax:=StrToInt(Edit12.Text);
  with Chart1 do
    begin
      LeftAxis.Automatic:=False;
      LeftAxis.Minimum:=oymin;
      LeftAxis.Maximum:=oymax;
      BottomAxis.Automatic:=False;
      BottomAxis.Minimum:=oxmin;
      BottomAxis.Maximum:=oxmax;
      SeriesList[0].Clear;
      case RadioGroup1.ItemIndex of
      0: Graph(sx,xn,xk,m,Chart1);
      1: Graph(yx,xn,xk,m,Chart1);
     end;
// Построение в TImage;
  with Image2.Canvas do
    begin
      Pen.Color:=clBlack;
      Brush.Color:=clBlue;
      xmax:=Image2.Width;
      ymax:=Image2.Height;
      y0:=Round(ymax/2);
      MoveTo(0,y0);
      LineTo(xmax,y0);
      MoveTo(0,0);
      LineTo(0,ymax);
      Pen.Color:=clPurple;
      Pen.Width:=2;
      xsc:=(oxmax-oxmin)/xmax;
      ysc:=(oymax-oymin)/ymax;
      case RadioGroup1.ItemIndex of
      0: IGraph(sx,xn,xk,xsc,ysc,y0,m,Image2);
      1: IGraph(yx,xn,xk,xsc,ysc,y0,m,Image2);
    end;
end;
end;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
  ClipBoard.Assign(Image2.Picture);
end;

end.
