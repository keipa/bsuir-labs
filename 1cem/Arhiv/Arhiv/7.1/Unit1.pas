unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;

    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject); private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  s,sr,smax:string;
   k:word;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 edit1.Clear;
 memo1.Clear;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
memo1.Clear;
if key=#13 then
begin
 s:=edit1.Text;
 s:=s+' ';
 repeat
  k:=Pos('  ',s);
  if k<>0 then Delete(s,k,1);
 until k=0;
 if s[1]=' ' then Delete(s,1,1);

 k:=pos(' ',s);
 repeat
  if k-1=5 then Memo1.Lines.Add(copy(s,1,k-1));
  delete(s,1,k);
  k:=pos(' ',s);
 until k=0;
end;
end;

end.
