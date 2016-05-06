unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    image2: TImage;
    Button1: TButton;
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
  Edit1.Text := '120';
  Edit2.Text := '50';
  Edit3.Text := '70';
  Edit4.Text := '90';
  Edit5.Text := '180';
  Edit6.Text := '100';
  Edit7.Text := '1';
  image2.Picture := nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  p : array[1..3] of TPoint;
  h : Extended;
begin
  image2.Picture :=  nil;
  with image2.Canvas do begin
    Pen.Color := clBlue;
    Brush.Color := clYellow;
    h := StrToFloat(Edit7.Text);
    p[1].x := Round(StrToFloat(Edit1.Text)/h);
    p[1].Y := Round(StrToFloat(Edit2.Text)/h);
    p[2].x := Round(StrToFloat(Edit3.Text)/h);
    p[2].Y := Round(StrToFloat(Edit4.Text)/h);
    p[3].x := round(StrTofloat(Edit5.Text)/h);
    p[3].y := Round(StrToFloat(Edit6.Text)/h);
    Polygon(p);                             
  end;

end;

end.
