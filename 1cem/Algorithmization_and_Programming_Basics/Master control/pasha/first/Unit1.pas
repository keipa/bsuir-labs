unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, Unit2;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TBitBtn;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    edt1: TEdit;
    edt2: TEdit;
    btn3: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    Button1: TButton;
    edt3: TEdit;
    lbl3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: array of Integer;
i,n,j,r:Integer;


implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);

var i:Integer;
begin
btn1.Visible:=True;
strngrd1.Visible:=True;
strngrd1.ColCount:=StrToInt(edt3.text)+1;
strngrd2.ColCount:=StrToInt(edt3.text)+1;                //create
for i:=1 to  StrToInt(edt3.Text)+1 do
 begin
  strngrd1.Cells[i,0]:=IntToStr(i);
  strngrd1.Cells[i,1]:=IntToStr(random(30));
 end;

end;





procedure TForm1.btn1Click(Sender: TObject);
begin
  strngrd2.Visible:=True;
 n:=StrToInt(edt3.text) ;
  SetLength(a,n);
  for I:=0 to n-1 do                            //input
  begin
    a[i]:=StrToInt(strngrd1.Cells[i+1,1]);
  end;

  sort(a,n);
  {
   for i:=0 to n-1 do
    for j:=0 to n do
      if a[i]> a[j]then
      begin
      r:=a[i];                                       //sorting
      a[i]:=a[j];
      a[j]:=r;
    end;
   }
   for I:=0 to n-1 do
  begin                                              //output
    strngrd2.Cells[i+1,1]:=inttostr(a[i]);
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  n:=StrToInt(edt3.text) ;
  strngrd2.ColCount:=strngrd2.ColCount+1;
  SetLength(a,n+1);
  n:=n+1;


 sdvig(a,StrToInt(edt2.Text)-1,StrToInt(edt1.text),n);
 {
 for i:=n  downto  StrToInt(edt2.Text) do
 begin                                                  //sdvig
   a[i]:=a[i-1];
   end;

  a[StrToInt(edt2.Text)-1] := StrToInt(edt1.text);
  }
for I:=0 to n-1 do
  begin                                              //output
    strngrd2.Cells[i+1,1]:=inttostr(a[i]);
  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
randomize;
end;

end.
