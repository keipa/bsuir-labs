unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button3: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Button6: TButton;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Label5: TLabel;
    Button5: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   Type
  Tinf=integer;
  TSeld=^Seld;
  Seld=record
      inf:Tinf;
      a,b:TSeld;
   end;
   var
   w1,wk,q:TSeld;inf:tinf; n:integer;
implementation

{$R *.dfm}

Procedure AddBegD(var w1,wk:Tseld; inf:Tinf); 
   var t:Tseld; 
begin 
  New(t); 
  t^.inf:=inf; 
  t^.b:=nil; 
  if w1=nil then begin t^.a:=nil; w1:=t; wk:=t; end 
            else begin t^.a:=w1; w1^.b:=t; w1:=t; end; 
end; 
 
 


Procedure AddEndD(var w1,wk:Tseld; inf:Tinf); 
   var t:Tseld; 
begin 
  New(t); 
  t^.inf:=inf; 
  t^.a:=nil; 
  if wk=nil then begin t^.b:=nil; w1:=t; wk:=t; end 
            else begin t^.b:=wk; wk^.a:=t; wk:=t; end; 
end; 
 

Procedure AddAfterD(sp:Tseld; inf:Tinf); 
   var t:Tseld; 
begin
  if (sp=nil) or (sp^.a=nil) then exit; 
  New(t); 
  t^.inf:=inf; 
  t^.a:=sp^.a; 
  t^.b:=sp; 
  sp^.a:=t; 
  t^.a^.b:=t; 
end; 
 

Procedure AddBefD(sp:Tseld; inf:Tinf); 
   var t:Tseld;
begin
  if (sp=nil) or (sp^.b=nil) then exit; 
  New(t); 
  t^.inf:=inf; 
  t^.a:=sp; 
  t^.b:=sp^.b; 
  sp^.b^.a:=t; 
  sp^.b:=t; 
end; 
   

Procedure DelBegD(var w1,wk:Tseld; var inf:Tinf);
   var t:Tseld; 
begin 
  if w1=nil then exit; 
  inf:=w1^.inf; 
  t:=w1;
    if w1=wk then begin w1:=nil; wk:=nil; end
           else begin w1^.a^.b:=nil; w1:=w1^.a; end;
  Dispose(t);
end;


Procedure DelEndD(var w1,wk:Tseld; var inf:Tinf); 
   var t:Tseld;
begin 
  if wk=nil then exit; 
  inf:=wk^.inf; 
  t:=wk; 
  if w1=wk then begin w1:=nil; wk:=nil; end 
           else begin wk^.b^.a:=nil; wk:=wk^.b; end; 
  Dispose(t); 
end; 
 

Procedure DelD(sp:Tseld; var inf:Tinf);
     begin
  if (sp=nil) or (sp^.a=nil) or (sp^.b=nil) then exit;
  inf:=sp^.inf;
  sp^.b^.a:=sp^.a;
  sp^.a^.b:=sp^.b;
  Dispose(sp);
end;

Procedure DelSpisD(var w1,wk:Tseld); 
   var inf:Tinf; 
begin 
  while w1<>nil do DelBegD(w1,wk,inf); 
end; 

procedure WrtBegD(w1:Tseld; s:TMemo); 
   var t:Tseld;  
begin 
   t:=w1;   s.clear; 
   while  t<>nil  do 
      begin 
      s.lines.add(IntToStr(t^.inf)); 
      t:=t^.a; 
      end;

end; 

procedure WrtEndD(wk:Tseld; s:TMemo); 
   var t:Tseld;   
begin 
   t:=wk;  s.clear; 
   while  t<>nil  do 
      begin 
      s.lines.add(IntToStr(t^.inf)); 
      t:=t^.b;     
      end; 
end; 
 

 
procedure slipD (var sq1,sqk,sr1,srk,sp1,spk:TSeld); 
     var  infq,infr:Tinf; 
 begin 
   sp1:=nil;   spk:=nil; 
   while (sq1<>nil) and (sr1<>nil) do 
     begin 
     DelBegD(sq1,sqk,infq); 
     DelBegD(sr1,srk,infr); 
     if infq<infr then begin 
                       AddEndD(sp1,spk,infq); 
                       AddBegD(sr1,srk,infr); 
                       end 
                  else begin 
                       AddEndD(sp1,spk,infr); 
                       AddBegD(sq1,sqk,infq); 
                       end; 
     end; 
   while sq1<>nil do 
     begin 
     DelBegD(sq1,sqk,infq); 
     AddEndD(sp1,spk,infq); 
     end; 
   while sr1<>nil do 
     begin 
     DelBegD(sr1,srk,infr);
     AddEndD(sp1,spk,infr);
     end; 
 end; 
 
procedure div2s(var sp1,spk,sq1,sqk,sr1,srk:TSeld); 
    var inf:Tinf;       
 begin 
   sr1:=nil;  srk:=nil; 
   sq1:=nil;  sqk:=nil; 
   while sp1<>nil do 
      begin 
      DelBegD(sp1,spk,inf); 
      AddEndD(sq1,sqk,inf); 
      if sp1<>nil then begin 
                       DelBegD(sp1,spk,inf); 
                       AddEndD(sr1,srk,inf); 
                       end; 
      end; 
 end; 
 
procedure sortslD(var w1,wk:TSeld); 
    var sq1,sr1,sqk,srk:TSeld; 
  begin 
    if w1<>wk then 
         begin 
         div2s(w1,wk,sq1,sqk,sr1,srk); 
         sortslD(sq1,sqk); 
         sortslD(sr1,srk); 
         slipD(sq1,sqk,sr1,srk,w1,wk); 
         end; 
  end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Label5.Caption:='';
  Randomize;
  Edit2.Clear;
  Memo1.Clear;
  w1:=nil;wk:=nil;
end;

procedure TForm1.Button6Click(Sender: TObject);
var i:byte;
begin  i:=1;
 Memo1.Clear;
 DelSpisD(w1,wk);
 while i<10 do begin
               AddEndD(w1,wk,-10+random(21));
               case RadioGroup2.ItemIndex of
                   0:WrtBegD(w1,Memo1);
                   1:WrtEndD (wk,Memo1);
                   end;
               inc(i);
               end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var t:tseld;k:integer;
begin
  if Edit2.text='' then  inf:=-10+Random(21)
   else
       inf:=strToint(Edit2.text);

  case RadioGroup1.ItemIndex of
        0: AddEndD(w1,wk,inf);
        1: AddBegD(w1,wk,inf);
              end;
  case RadioGroup2.ItemIndex of
        0:WrtBegD(w1,Memo1);
        1:WrtEndD (wk,Memo1);
              end;
 Edit2.Clear;
end;

procedure TForm1.Button4Click(Sender: TObject);
var k:integer;t:tseld;
begin
  SortSlD( w1,wk);
  Memo1.Clear;
  case RadioGroup2.ItemIndex of
       0:WrtBegD(w1,Memo1);
       1:WrtEndD (wk,Memo1);
            end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var t,p:tseld;
begin
 case   RadioGroup3.ItemIndex of
  0:     DelBegD(w1,wk,inf);
  1:     DelEndD(w1,wk,inf);
  2:    begin t:=w1; while t<>nil do
              if  t^.inf=strtoint(Edit1.Text) then DelD(t,inf);
         end;end;


 case RadioGroup2.ItemIndex of
        0:WrtBegD(w1,Memo1);
        1:WrtEndD (wk,Memo1);
        end;
 Edit1.clear;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
      DelSpisD(w1,wk);
end;

procedure TForm1.Button5Click(Sender: TObject);
     var f,n,m,k:integer; s:extended; t:tseld;
begin
if Edit3.Text='' then f:=0
else f:=StrToInt(Edit3.Text);
s:=0;
m:=0;
t:=w1;
while t<>nil do
    begin
    k:=t^.inf;
    s:=s+k;
    t:=t^.a;
    end;
     s:=s/(10+f); t:=w1;
    while t<>nil do
    begin
    k:=t^.inf;
    if k<s then inc(m);
    t:=t^.a;
    end;

 Label5.Caption:='Среднее значение очереди = '+FloatToStr(s)+#13+'Количество элементов меньше среднего='+IntToStr(m);
end;



end.

