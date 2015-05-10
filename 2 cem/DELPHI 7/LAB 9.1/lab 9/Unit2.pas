unit Unit2;
Interface
 Uses   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;
Type
   Tkey=integer;
   Tinf=Record
     Fio:string;
     key:integer;
       end;
   Psel=^sel;
    sel=Record
    inf:Tinf;
      A:Psel;
        end;
   Ms=array[0..1] of Psel;
   Pms=^Ms;
TH=class(Tobject)
     n:Word;
     sp,sp1:psel;
    Constructor create(M0:word);
    Destructor Free(Var stringgrid:TStringGrid);
    Procedure Add(Inf:Tinf);
    Procedure Read(key:Tkey; Var Inf:Tinf);
    Procedure Red(key:Tkey; Var Inf:Tinf);
    procedure Print(M1:Tmemo;h:Pms);
end;
TR=class(TH)
     procedure add1(Inf:Tinf);
     procedure add2(Inf:Tinf);
     procedure po;
end;
var H,Hp,Ho:Pms;   m:word; n1,n2:Word;
implementation

Constructor TH.create(M0:word);
    Var i:word;
    begin   Inherited create;
       M:=M0; n:=0;
       Getmem(H,M*4);
       for i:=0 to M-1 do H[i]:=Nil;
    end;

Destructor TH.Free;
  Var i,j:word;
 begin
   j:=0;
    for i:=0 to M-1 do
      While H[i]<>Nil do begin
            Inc(j); sp:=H[i];
    StringGrid.Cells[0,j]:=sp^.inf.Fio;
    StringGrid.Cells[1,j]:=IntToStr(sp^.inf.key);
          H[i]:= sp^.A;
          dispose(sp);
    end;
   FreeMem(H,4*M);
end;

Procedure TH.Add;// добавить новую запись
  var i: integer;
      p:Psel;
begin
 i:=abs(inf.key Mod M);
   New(p);  Inc(n);
    p^.Inf:=Inf;
    p^.A:=H[i];
  H[i]:=p;
end;

Procedure TH.Read;//чтение без удаления
  var i: integer;
 begin
   i:=key mod M;
     sp:=H[i];
 While (sp<>Nil) and
                 (sp^.inf.key<>key) do sp:=sp^.A;
  if sp<>Nil then inf:=sp^.inf
             else ShowMessage('ключ не найден');
end;


procedure TH.Print;
var i:integer;
begin
  for i:=0 to M-1 do
    if H[i]<>Nil then        begin
      sp:=h[i];
           while sp<>Nil do
          begin
            M1.Lines.Add(sp^.inf.FIO+' '+IntToStr(sp^.inf.key));
            sp:=sp^.A;
          end; end; end;

procedure TH.Red;
var i:integer;
begin
  i:=key mod M;
  sp:=H[i];
  sp1:=sp;
  while (sp<>Nil) and (sp^.inf.key<>key) do
    begin
      sp1:=sp;
      sp:=sp^.A;
    end;
  if sp<>Nil then
    begin
      inf:=sp^.inf;
      if sp1=sp then
        H[i]:=sp^.A
      else
        sp1^.A:=sp^.A;
      Dispose(sp);
      Dec(n);
    end
  else
    ShowMessage('Ключ не найден');
end;

procedure tr.po;
var i:integer; sp:psel;
begin
new(sp);
n1:=0; n2:=0;
       Getmem(Hp,M*4);
       for i:=0 to M-1 do Hp[i]:=Nil;
              Getmem(Ho,M*4);
       for i:=0 to M-1 do Ho[i]:=Nil;
  for i:=0 to M-1 do
    if H[i]<>Nil then begin
    sp:=h[i];
     while sp<>Nil do
          begin
            if sp.inf.key<0 then add2(sp.inf) else add1(sp.inf);
            sp:=sp^.A; end;
          end;
end;

Procedure Tr.Add1;// добавить новую запись
  var i: integer;
      p:Psel;
begin
 i:=abs(inf.key Mod M);
   New(p);
   Inc(n1);
    p^.Inf:=Inf;
    p^.A:=Hp[i];
  Hp[i]:=p;
end;

Procedure Tr.Add2;// добавить новую запись
  var i: integer;
      p:Psel;
begin
 i:=abs(inf.key Mod M);
   New(p);  Inc(n2);
    p^.Inf:=Inf;
    p^.A:=Ho[i];
  Ho[i]:=p;
end;
end.
