unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Unit2;


type
    TForm1 = class(TForm)
    Edit1: TEdit;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);


    procedure Button5Click(Sender: TObject);
   
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }


  end;
var
  Form1: TForm1;
   lists:TLists;

implementation



{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var i,k:integer;
begin
  randomize;
  k:=Random(100);
  lists.init(p,k);
  lists.init(tmp,k);
  for i:=1 to 9 do begin
    k:=Random(100);
    lists.add(p,k);
    lists.add(tmp,k);

  end;
  lists.shows(p,Form1.ListBox1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Edit1.Text=''
    then Edit1.Text:=IntToStr(0);
  lists.add(p,StrToInt(Edit1.Text));
  lists.shows(p,Form1.ListBox1);
  Edit1.Clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
//  lists.bubblesort(p);
   ListBox1.Clear;
   lists.minup(p,Form1.ListBox1);
 //lists.shows(p,Form1.ListBox1);
  //  lists.shows(p,Form1.ListBox1);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  lists:=TLists.create;
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
  lists.Dell(p,StrToInt(Edit1.Text));
  lists.shows(p,Form1.ListBox1);
  Edit1.Text:='';

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if Edit1.Text=''
    then Edit1.Text:=IntToStr(0);
  lists.addafter(p,StrToInt(Edit1.Text));
  lists.shows(p,Form1.ListBox1);
  Edit1.Clear;
end;

end.


