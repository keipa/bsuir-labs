unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    BitBtn1: TBitBtn;
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
memo1.Clear;
edit1.Text:='';
edit2.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var s:string;
i,j,n,k,m:integer;
begin
 s:=edit1.text;
 k:=strtoint(edit2.Text);
 delete(s,k+1,length(s)-k);
 while s[length(s)]=' ' do delete(s,length(s),1);
 while pos('  ',s)<>0 do delete(s,pos('  ',s),1);
 while s[1]=' ' do delete(s,1,1);
 i:=1;
 while pos(' ',s)<>0 do
  begin
   inc(i);
   delete(s,1,pos(' ',s));
  end;
 memo1.Lines.Add('Номер слова: '+inttostr(i));
end;

end.
