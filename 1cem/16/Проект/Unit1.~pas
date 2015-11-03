unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Unit2, ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    Memo2: TMemo;
    Button2: TButton;
    Button3: TButton;
    Memo3: TMemo;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Button4: TButton;
    RadioGroup4: TRadioGroup;
    LabeledEdit2: TLabeledEdit;
    Edit1: TEdit;
    Button5: TButton;
    LabeledEdit3: TLabeledEdit;
    Button6: TButton;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    StatusBar1: TStatusBar;
    Button7: TButton;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  List,sq,sr:TList;
  b:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  List:=TList.Create;
  Memo2.Clear;
  Memo3.Clear;
  LabeledEdit3.Text:='10';
end;

procedure TForm1.Button1Click(Sender: TObject);
var x:integer;
begin
  x:=StrToInt(LabeledEdit1.Text);
  case RadioGroup3.ItemIndex of
    0: begin
        List.AddFFirst(x);
        StatusBar1.SimpleText:='Элемент добавлен в начало списка';
       end;
    1: begin
        List.AddFLast(x);
        StatusBar1.SimpleText:='Элемент добавлен в конец списка';
       end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var x:integer;
begin
  Memo2.Clear;
  with List do
    begin
      case RadioGroup1.ItemIndex of
        0:begin
            ReadFFirst(x);
            if b1 then
              Memo2.Lines.Add(IntToStr(x));
          end;
        1:begin
            ReadFLast(x);
            if bk then
              Memo2.Lines.Add(IntToStr(x));
          end;
      end;
  end;
  StatusBar1.SimpleText:='Элемент прочтён и удалён';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo3.Clear;
  case RadioGroup2.ItemIndex of
    0:List.PrintFFirst(Memo3);
    1:List.PrintFLast(Memo3);
  end;
  StatusBar1.SimpleText:='Список успешно выведен';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SortSlip(List);
  StatusBar1.SimpleText:='Список успешно отсортирован';
end;

procedure TForm1.Button5Click(Sender: TObject);
var x,y:integer;
begin
  x:=StrToInt(LabeledEdit2.Text);
  y:=StrToInt(Edit1.Text);
  with List do
    begin
      Size;
      case RadioGroup4.ItemIndex of
        0:AddBefore(y,x);
        1:AddAfter(y,x);
      end;
    end;
  StatusBar1.SimpleText:='Элемент успешно добавлен';
end;

procedure TForm1.Button6Click(Sender: TObject);
var i,L,x:integer;
begin
  L:=StrToInt(LabeledEdit3.Text);
  for i:=1 to L do
    begin
      Randomize;
      x:=Random(40);
      List.AddFFirst(x);
    end;
  StatusBar1.SimpleText:='Список создан и заполнен элементами';  
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  List.SearchAndChange(List.sp1);
  StatusBar1.SimpleText:='Перестановка элементов завершена';
end;

end.
