unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Edit5: TEdit;
    BitBtn1: TBitBtn;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Button3: TButton;
    Edit6: TEdit;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type razg=record
         gor:string[30];
         time:integer;
         tar:integer;
         nom:integer;
         end;
   var a:array of razg;
         k:integer;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure add(avs:Razg; nvs:integer);
begin
  setlength(a,high(a)+2);
  for k:=high(a)-1 downto nvs do a[k+1]:=a[k];
  a[nvs]:=avs;
end;

procedure del(nyd:integer);
begin
  for k:=nyd+1 to high(a) do a[k-1]:=a[k];
  setlength(a,high(a));
  end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.clear;  Edit2.clear;  Edit3.clear;
 Edit4.clear;  Edit5.clear;  Edit6.Clear;
 Memo1.clear;  memo2.clear;  memo3.clear;
 memo4.clear;  memo5.Clear;  label5.Caption:='';
 button2.Enabled:=false;
 Button3.Enabled:=false;
end;




procedure TForm1.Button1Click(Sender: TObject);
     var n:integer;
           w:razg;
begin

  w.gor:=Edit1.Text;
  w.time:=StrToInt(edit2.Text);
  w.tar:=strtoint(Edit3.text);
  w.nom:=strtoint(Edit4.Text);
  if high(a)=-1 then
    begin setlength(a,1); a[0]:=w; end

                else
     begin
     n:=high(a)+1;
     for k:=0 to high(a) do
        if w.gor<a[k].gor then begin n:=k; break;  end;
     add(w,n);
     end;
    memo1.clear; memo2.clear;memo3.clear;memo4.clear;
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  for k:=0 to high(a) do
  begin
  memo1.Lines.Add(inttostr(k+1)+'.'+a[k].gor);
  memo3.Lines.Add(floattostr(a[k].tar));
  memo2.Lines.Add(inttostr(a[k].time));
  memo4.Lines.Add(inttostr(a[k].nom));
  end;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
a:=nil;
end;

procedure TForm1.Button2Click(Sender: TObject);
  var n:integer;
begin
  n:=strtoint(edit5.Text)-1;
  if n>high(a) then
     begin
     edit5.Clear;   exit;
     end;
  del(n);
  memo1.clear;
  memo2.clear;
  memo3.clear;
  memo4.clear;
  for k:=0 to high(a) do  begin
  memo1.Lines.Add(inttostr(k+1)+'.'+a[k].gor);
  memo2.Lines.Add(inttostr(a[k].time));
  memo3.Lines.Add(inttostr(a[k].tar));
  memo4.Lines.Add(inttostr(a[k].nom));
  end;

  Edit5.Clear;
end;
procedure TForm1.Edit5Change(Sender: TObject);
begin
 if Edit5.Text<>'' Then Button2.Enabled:=true;
end;


procedure TForm1.Edit6Change(Sender: TObject);
begin
 if Edit6.Text<>'' then Button3.Enabled:=true;
end;


procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
   Memo5.Clear; Memo6.Clear; Memo7.Clear; Memo8.Clear;
    for i:=0 to high(a) do
    if a[i].gor=Edit6.text then
   begin
   Memo5.Lines.Add(inttostr(i+1)+'.'+a[i].gor);
   Memo6.Lines.Add(inttostr(a[i].time));
   Memo7.Lines.Add(inttostr(a[i].tar));
   Memo8.Lines.Add(inttostr(a[i].nom));                         
   end
else  Label5.Caption:='элемент не найден';

end;

end.
