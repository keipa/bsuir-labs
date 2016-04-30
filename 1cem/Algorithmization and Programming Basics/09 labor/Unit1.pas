unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, math;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    Graph: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    TabSheet1: TTabSheet;
    Image1: TImage;
    BitBtn1: TBitBtn;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    TrackBar1: TTrackBar;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ab,ac,bc:integer;
begin
ab:=strtoint(edit1.text);
bc:=strtoint(edit2.text);
ac:=strtoint(edit3.text);

if (ac+bc>ab) and (ab+bc>ac) and (ac+ab>bc) then
showmessage('ok, now click GRAPH')
else
showmessage('Reenter sides')
end;

function PifProof(a,b,c:integer):integer;
var ab,ac,bc:integer;
begin
ab:=a;
bc:=b;
ac:=c;
if (sqrt(ac*ac+bc*bc)=ab) or (sqrt(ab*ab+bc*bc)=ac) or (sqrt(ac*ac+ab*ab)=bc) then
PifProof:=0
else
PifProof:=1
end;

procedure TForm1.Button2Click(Sender: TObject);
var ab,ac,bc,xmax,ymax:integer;
     abr,bcr,acr:real;
begin
  xmax:=90;
  abr:=strtoint(edit1.text);
  bcr:=strtoint(edit2.text);
  acr:=strtoint(edit3.text);
  case trackbar1.Position of
  1 : begin abr:=abr/100; acr:=acr/100; bcr:=bcr/100;  end;
  2 : begin abr:=abr/25; acr:=acr/25; bcr:=bcr/25; end;
  3 : begin abr:=abr/10; acr:=acr/10; bcr:=bcr/10; end;
  4 : begin abr:=abr/2; acr:=acr/2; bcr:=bcr/2; end;
  6 : begin abr:=abr*2; acr:=acr*2; bcr:=bcr*2; end;
  7 : begin abr:=abr*4; acr:=ac*4; bcr:=bcr*4; end;
  8 : begin abr:=abr*8; acr:=acr*8; bcr:=bcr*8; end;
  9 : begin abr:=abr*16; acr:=acr*16; bcr:=bcr*16; end;
  10 : begin abr:=abr*32; acr:=acr*32; bcr:=bcr*32; end;
  end;
  ab:=round(abr);
  bc:=round(bcr);
  ac:=round(acr);

with image1.canvas do
begin
  if pifproof(ab,bc,ac)=0 then
   begin
    showmessage('Now, go to the graph page using pifagor');
    pen.color:=clRed;
    Brush.color:=clRed;
    Pen.Width:=2;
    moveto (200,170);
    lineto(200+ab,170);
    lineto(200+ab,170-bc);
    lineto(200,170);
   end
  else
  begin
    showmessage('Now, go to the graph page');
    pen.color:=clRed;
    Brush.color:=clRed;
    Pen.Width:=2;

    ymax:=Image1.Height;
    moveto (200,170);
    lineto(200+ab,170);
  while sqrt(abr*abr+bcr*bcr)>ac do
     begin
       abr:=ab*cos(xmax);
       bcr:=bc*sin(xmax);
       xmax:=xmax-1;
     end;
  ab:=round(abr);
  bc:=round(bcr);
  lineto(200-ab,170-bc);
  lineto(200,170);
  end;
  end;
end;



end.
