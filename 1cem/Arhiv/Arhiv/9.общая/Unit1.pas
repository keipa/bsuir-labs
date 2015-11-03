unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
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
begin
 with form1.Canvas do
  begin
   pen.Width:=3;
   pen.color:=clred;
   brush.Style:=bsCross;
   brush.color:=clgreen;
   polygon([point(190,30),point(240,60),point(170,40)]);
   polyline([point(290,30),point(340,60),point(270,40)]);
   rectangle(200,100,280,140);
   ellipse(20,150,220,220);
   font.Color:=clblue;
   font.Size:=50;
   textout(350,120,'test');
  end;
  
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 refresh;
end;

end.
