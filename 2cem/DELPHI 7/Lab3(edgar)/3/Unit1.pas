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
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  IOA = record
    Info: TInfo;
    key: TKey;
  end;
  Mas=array [1..1000] of IOA;

  InfoAboutWorkers = class(TObject);
  a:Mas;
  n:Word;


var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.btn1Click(Sender: TObject);
begin
 edit2.Clear;
 edit3.Clear;
 edit4.Clear;
 edit5.Clear;
 edit6.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
var z,x:Integer;
begin
 mmo1.Clear;
 edit2.Clear;
 edit3.Clear;
 edit4.Clear;
 edit5.Clear;
 edit6.Clear;
 edit7.Clear;
 repeat
   begin
   end;
 until (edit2.Text='') and (edit3.Text='') and (edit4.Text='')
 and(edit5.Text='') and(edit6.Text='');
end;

end.
