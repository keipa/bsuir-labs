unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
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
 edit1.clear;
 Memo1.clear;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var s:string;
    n,k,min,i,j:integer;
    a:array[1..100] of string;
    q:set of char;
begin
if key=#13 then
begin
 Memo1.Clear;
 S:=Edit1.Text;
 S:=S+' ';
 repeat
  k:=Pos('  ',s);
  if k<>0 then Delete (s,k,1);
 until k=0;
 if S[1]=' ' then delete(s,1,1);

 n:=0;
 k:=pos(' ',s);
 while k<>0 do
  begin
   inc(n);
   a[n]:=copy(s,1,k-1);
   delete(s,1,k);
   k:=pos(' ',s);
  end;

 min:=length(a[1]);
 for i:=2 to n do
  if length(a[i])<min then min:=length(a[i]);
 memo1.Lines.Add('Минимальная длинна: '+inttostr(min));

 for i:=1 to n do
  if length(a[i])=min then
   begin
    memo1.Lines.Add('------------');
    memo1.Lines.Add('Слово: '+a[i]);
    memo1.Lines.Add('Порядковый номер: '+inttostr(i));
    q:=[];
    k:=0;
    for j:=1 to length(a[i]) do
     if not (a[i][j] in q) then
      begin
       q:=q+[a[i][j]];
       inc(k);
      end;
    memo1.Lines.Add('Кол-во различных символов: '+inttostr(k));
   end;
end;
end;

end.
