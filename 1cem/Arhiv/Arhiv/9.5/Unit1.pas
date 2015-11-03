unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
Memo1.Clear;
Edit4.Clear;
  SetWindowLong(Edit1.Handle, GWL_STYLE,
    GetWindowLong(Edit1.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(Edit2.Handle, GWL_STYLE,
    GetWindowLong(Edit2.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(Edit3.Handle, GWL_STYLE,
     GetWindowLong(Edit3.Handle, GWL_STYLE) or ES_NUMBER);
  Image1.Canvas.Brush.Color := clgreen;
  Image1.Canvas.rectangle(0,0,image1.Width-1,
     image1.Height-1);
     end;

procedure TForm1.Button1Click(Sender: TObject);
var
 R : integer;
 x0, y0 : integer;
begin
  R := StrToInt(Edit1.Text);
  x0 := StrToInt(Edit2.Text);
  y0 := StrToInt(Edit3.Text);
  Image1.Canvas.Brush.Color := clRed;
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.Ellipse(x0-r, y0-r, x0 + R, y0+R);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i, j, n : integer;
begin
  for i := 0 to image1.Width do
    for j := 0 to image1.Height do
      if Image1.Canvas.Pixels[i, j] = clRed then
      begin
  inc(n);
  Edit4.Text:=inttostr(n);
  Memo1.Lines.Add('X: ' + inttostr(i) + 'Y: ' + inttostr(j));
   end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i,j :integer ;
begin
Memo1.Clear;
Edit4.Clear;
 for i := 0 to image1.Width do
    for j := 0 to image1.Height do
      if Image1.Canvas.Pixels[i, j] = clRed then
         Image1.Canvas.Pixels[i, j]:= clgreen;
end;

end.
