unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UStack, Buttons;
type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Button9: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  Zad: TZad;
implementation
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 Zad:= TZad.Create;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Zad.Adds(StrToInt(Edit1.Text));
 Zad.Print(ListBox1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var Inf: TInf;
begin
 Inf:= StrToInt(Edit1.Text);
 Zad.Reads(Inf);
 Zad.Print(ListBox1);
end;

procedure TForm1.Button3Click(Sender: TObject);
var spa: Sel;
begin
 if ListBox1.ItemIndex >= 0 then
  begin
   spa:= Zad.GetSel(ListBox1.ItemIndex);
   Zad.AddAfter(spa,StrToInt(Edit1.Text));
   Zad.Print(ListBox1);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var Inf: TInf;
    spa: Sel;
begin
 Inf:= StrToInt(Edit1.Text);
 if ListBox1.ItemIndex >= 0 then
  begin
   spa:= Zad.GetSel(ListBox1.ItemIndex);
   Zad.ReadAfter(spa,Inf);
   Zad.Print(ListBox1);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 ListBox1.ItemIndex:= Zad.Poisk(StrToInt(Edit1.Text));
end;

procedure TForm1.Button6Click(Sender: TObject);
var spa: Sel;
begin
 if ListBox1.ItemIndex >= 0 then
  begin
   spa:= Zad.GetSel(ListBox1.ItemIndex);
   ListBox1.ItemIndex:= Zad.PoiskAfter(spa,StrToInt(Edit1.Text));
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Zad.SortBublInf();
  Zad.Print(ListBox1);
end;

procedure TForm1.Button8Click(Sender: TObject);
var spa: Sel;
    inx: integer;
begin
 if ListBox1.ItemIndex >= 0 then
  begin
   spa:= Zad.GetSel(ListBox1.ItemIndex);
   Zad.SortBublAfter(spa);
   inx:=ListBox1.ItemIndex;
   Zad.Print(ListBox1);
   ListBox1.ItemIndex:=inx;
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var i: integer;
begin
 i:= Zad.Task;
 Zad.Print(ListBox1);
 ListBox1.ItemIndex:= i;
 Edit1.Text:= IntToStr(i);
end;
end.
