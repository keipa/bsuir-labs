unit StekProc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

 type
  Tinf=integer;
  TSel=^sel;
  Sel=record
   inf:Tinf;
   a:Tsel;
  end;

 procedure AddStek(var w:TSel; inf:TInf);
 procedure ReadStek(w:TSel; n:integer; var inf:Tinf);
 procedure DelLast(var w:TSel; var inf:Tinf);
 procedure DelStek(var w:TSel);
 procedure RevAfter(sp:TSel);
 procedure RevInf(sp:TSel);
 procedure SortAfter(var w:TSel);
 procedure SortInf(w:TSel);
 procedure WriteStek(w:TSel; Memo:TMemo);
 procedure AddBeg(var w1,wk:TSel; inf:Tinf);
 procedure AddEnd(var w1,wk:TSel; inf:Tinf);
 procedure AddAfter(sp:TSel; inf:Tinf);
 procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
 procedure DelAfter(sp:TSel; var inf:Tinf);
 procedure DelSpis(var w1,wk:TSel);
 procedure slip(var sq1,sqk,sr1,srk,sp1,spk:TSel);
 procedure div1s(var sp1,spk,sq1,sqk,sr1,srk:TSel);
 procedure SortSl(var w1,wk:TSel);
 procedure WriteSpis(w1,wk:TSel; Memo:TMemo);
 
implementation

procedure AddStek(var w:TSel; inf:TInf);
 var t:TSel;
begin
 New(t);
 t^.inf:=inf;
 t^.a:=w;
 w:=t;
end;

procedure ReadStek(w:TSel; n:integer; var inf:Tinf);
 var i:integer;
     t:TSel;
begin
 if w=nil then exit;
 t:=w;
 for i:=1 to n do
  begin
   inf:=t^.inf;
   t:=t^.a;
  end;
end;

procedure DelLast(var w:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w=nil then exit;
 inf:=w^.inf;
 t:=w;
 w:=w^.a;
 dispose(t);
end;

procedure DelStek(var w:TSel);
 var inf:Tinf;
begin
 while w<>nil do DelLast(w,inf);
end;

Procedure RevAfter(sp:TSel);
 var t:TSel;
begin
 t:=sp^.a^.a;
 sp^.a^.a:=t^.a;
 t^.a:=sp^.a;
 sp^.a:=t;
end;

procedure RevInf(sp:TSel);
 var inf:Tinf;
begin
 inf:=sp^.inf;
 sp^.inf:=sp^.a.inf;
 sp^.a^.inf:=inf;
end;

procedure SortAfter(var w:TSel);
 var p,t:TSel;
     inf:Tinf;
begin
 if (w=nil) or (w.a=nil) then exit;
 AddStek(w,0);
 t:=nil;
 repeat
  p:=w;
  while p^.a^.a<>t do
   begin
    if p^.a^.inf>p^.a^.a^.inf then RevAfter(p);
    p:=p^.a;
   end;
  t:=p^.a;
 until w^.a^.a=t;
 DelLast(w,inf);
end;

procedure SortInf(w:TSel);
 var p,t:TSel;
begin
 if (w=nil) or (w.a=nil) then exit;
 t:=nil;
 repeat
  p:=w;
  while p^.a<>t do
   begin
    if p^.inf>p^.a^.inf then revInf(p);
    p:=p^.a;
   end;
  t:=p;
 until w^.a=t;
end;

Procedure WriteStek(w:TSel; Memo:TMemo);
 var t:Tsel;
begin
 Memo.clear;
 t:=w;
 while t<>nil do
  begin
   Memo.lines.add(inttostr(t^.inf));
   t:=t^.a;
  end;
end;

procedure AddBeg(var w1,wk:TSel; inf:Tinf);
 var t:TSel;
begin
 if w1=nil then
  begin
   new(w1);
   w1^.inf:=inf;
   w1^.a:=nil;
   wk:=w1;
  end
 else
  begin
   new(t);
   t^.inf:=inf;
   t^.a:=w1;
   w1:=t;
  end;
end;

procedure AddEnd(var w1,wk:TSel; inf:Tinf);
 var t:TSel;
begin
 if wk=nil then
  begin
   new(wk);
   wk^.inf:=inf;
   wk^.a:=nil;
   w1:=wk;
  end
 else
  begin
   new(t);
   t^.inf:=inf;
   t^.a:=nil;
   wk^.a:=t;
   wk:=t;
  end;
end;

procedure AddAfter(sp:TSel; inf:Tinf);
 var t:TSel;
begin
 if sp^.a=nil then exit;
 new(t);
 t^.inf:=inf;
 t^.a:=sp^.a;
 sp^.a:=t;
end;

procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w1=nil then exit;
 inf:=w1^.inf;
 t:=w1;
 w1:=w1^.a;
 dispose(t);
 if w1=nil then wk:=nil;
end;

procedure DelAfter(sp:TSel; var inf:Tinf);
 var t:TSel;
begin
 if (sp^.a=nil) then exit;
 if sp^.a^.a=nil then
  begin
   sp^.a:=nil;
   wk:=sp;
   exit;
  end;
 t:=sp^.a;
 inf:=t^.inf;
 sp^.a:=t^.a;
 dispose(t);
end;

Procedure DelSpis(var w1,wk:TSel);
 var a:Tinf;
begin
 while w1<>nil do DelBeg(w1,wk,a);
end;

Procedure slip(var sq1,sqk,sr1,srk,sp1,spk:TSel);
 var infq,infr:Tinf;
begin
 sp1:=nil; spk:=nil;
 while (sq1<>nil) and (sr1<>nil) do
  begin
   DelBeg(sq1,sqk,infq);
   DelBeg(sr1,srk,infr);
   if infq<infr then
    begin
     AddEnd(sp1,spk,infq);
     AddBeg(sr1,srk,infr);
    end
   else
    begin
     AddEnd(sp1,spk,infr);
     AddBeg(sq1,sqk,infq);
    end;
  end;
 while sq1<>nil do
  begin
   DelBeg(sq1,sqk,infq);
   AddEnd(sp1,spk,infq);
  end;
 while sr1<>nil do
  begin
   DelBeg(sr1,srk,infr);
   AddEnd(sp1,spk,infr);
  end;
end;

Procedure div1s(var sp1,spk,sq1,sqk,sr1,srk:TSel);
 var inf:Tinf;
begin
 sr1:=nil; srk:=nil;
 sq1:=nil; sqk:=nil;
 while sp1<>nil do
  begin
   delbeg(sp1,spk,inf);
   AddEnd(sq1,sqk,inf);
   if sp1<>nil then
    begin
     DelBeg(sp1,spk,inf);
     AddEnd(sr1,srk,inf);
    end;
  end;
end;

Procedure SortSl(var w1,wk:TSel);
 var sq1,sqk,sr1,srk:TSel;
begin
 if w1<>wk then
  begin
   div1s(w1,wk,sq1,sqk,sr1,srk);
   sortsl(sq1,sqk);
   sortsl(sr1,srk);
   slip(sq1,sqk,sr1,srk,w1,wk);
  end;
end;

Procedure WriteSpis(w1,wk:TSel; Memo:TMemo);
 var t:Tsel;
begin
 Memo.clear;
 t:=w1;
 while t<>nil do
  begin
   Memo.lines.add(inttostr(t^.inf));
   t:=t^.a;
  end;
end;

end.
