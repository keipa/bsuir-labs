unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl1: TLabel;
    edit2: TEdit;
    lbl2: TLabel;
    edit3: TEdit;
    lbl3: TLabel;
    edit4: TEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    btn1: TButton;
    btn2: TButton;
    lbl10: TLabel;
    ts4: TTabSheet;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    edit7: TEdit;
    btn6: TButton;
    lbl11: TLabel;
    lbl12: TLabel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    Memo1: TMemo;
    StaticText1: TStaticText;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public

   end;
var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.btn1Click(Sender: TObject);
begin
 edit2.Clear;
 edit3.Clear;
 edit4.Clear;

end;

procedure TForm1.FormCreate(Sender: TObject);
var z,x:Integer;
begin

 edit2.Clear;
 edit3.Clear;
 edit4.Clear;

end;
end.
