unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, biblio;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
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
edit1.Text:='0,2';
edit2.Text:='0,8';
edit3.Text:='10';
edit4.Text:='0,001';
edit5.Text:='';
memo1.clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var M,a,b,h,x,s,eps:extended;
    it:word;
begin
try
 a:=StrToFloat(Edit1.text);
 b:=StrToFloat(Edit2.text);
 M:=StrToFloat(Edit3.text);
 eps:=StrToFloat(Edit4.text);
 h:=(b-a)/m; edit5.Text:=floattostrf(h,fffixed,8,2);
 x:=a;
 repeat
  sum(x,eps,s,it);  
  memo1.Lines.Add(floattostrf(x,fffixed,5,2)+
          '     '+floattostrf(s,fffixed,9,6)+
          '     '+floattostrf(y(x),fffixed,9,6)+
          '     '+inttostr(it));
  x:=x+h;
 until x>b+1E-9;
except
 on EconvertError do
  begin
   ShowMessage('Проверьте значение числа');
   Exit;
  end;
 on EOverFlow do
  begin
   Messagedlg('переполнение при выполнении операции с плавающей точкой',mterror,[mbcancel],0);
   Exit;
  end;
 on EInvalidOp do
  begin
   Messagedlg('Неправильная операция с плавающей точкой',mterror,[mbcancel],0);
   Exit;
  end;
 else
  begin
   Messagedlg('Возникла неизвестная исключительная ситуация! ',mterror,[mbcancel],0);
   Exit;
  end;
end;
end;

end.
