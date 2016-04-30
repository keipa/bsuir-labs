unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit2;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SaveDiaog1: TSaveDialog;
    Label1: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
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
  ans : longint;
begin
  if SaveDiaog1.Execute then begin
    Assignfile(fl,SaveDiaog1.FileName);
  end;
  ans := calc(fl,'(') + calc(fl,')');
  Edit1.Text := IntToStr(ans);
end;

end.
