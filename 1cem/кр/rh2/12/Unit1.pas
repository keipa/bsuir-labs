unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    SaveDiaog1: TSaveDialog;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fl : tfl;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  fname : string;
  x,y : Char;
begin
  if SaveDiaog1.Execute then begin
    fname := SaveDiaog1.FileName;
    Assignfile(fl,fname);
    Reset(fl);
  end;
  x := Edit1.text[1];
  y := Edit2.text[1];
  zamena(fl,x,y);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text :='i';
  Edit2.Text :='[';
end;

end.
