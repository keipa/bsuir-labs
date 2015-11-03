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
  TSeld=^Seld;
  Seld=record
   inf:Tinf;
   a,b:TSeld;
  end;

 Procedure AddStek(var w:TSel; inf:TInf);
 Procedure ReadStek(w:TSel; n:integer; var inf:Tinf);
 Procedure DelLast(var w:TSel; var inf:Tinf);
 Procedure DelAfterStek(sp:TSel; var inf:Tinf);
 Procedure DelStek(var w:TSel);
 Procedure RevAfter(sp:TSel);
 Procedure RevInf(sp:TSel);
 Procedure SortAfter(var w:TSel);
 Procedure SortInf(w:TSel);
 Procedure WriteStek(w:TSel; Memo:TMemo);
 Procedure AddBeg(var w1,wk:TSel; inf:Tinf);
 Procedure AddEnd(var w1,wk:TSel; inf:Tinf);
 Procedure AddAfter(sp:TSel; inf:Tinf);
 Procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
 Procedure DelAfterSpis(var w1,wk,sp:TSel; var inf:Tinf);
 Procedure DelSpis(var w1,wk:TSel);
 Procedure slip(var sq1,sqk,sr1,srk,sp1,spk:TSel);
 Procedure div1s(var sp1,spk,sq1,sqk,sr1,srk:TSel);
 Procedure SortSl(var w1,wk:TSel);
 Procedure WriteSpis(w1,wk:TSel; Memo:TMemo);
 Procedure AddBegD(var w1,wk:Tseld; inf:Tinf);
 Procedure AddEndD(var w1,wk:Tseld; inf:Tinf);
 Procedure AddAfterD(sp:Tseld; inf:Tinf);
 Procedure AddBefD(sp:Tseld; inf:Tinf);
 Procedure DelBegD(var w1,wk:Tseld; var inf:Tinf);
 Procedure DelEndD(var w1,wk:Tseld; var inf:Tinf);
 Procedure DelD(var w1,wk,sp:Tseld; var inf:Tinf);
 Procedure DelSpisD(var w1,wk:Tseld);
 Procedure WrtBegD(w1:Tseld; s:TMemo);
 Procedure WrtEndD(wk:Tseld; s:TMemo);
 Procedure slipD (var sq1,sqk,sr1,srk,sp1,spk:TSeld);
 Procedure div2s(var sp1,spk,sq1,sqk,sr1,srk:TSeld);
 Procedure sortslD(var w1,wk:TSeld);

implementation

   {---------ÑÒÅÊ---------}

Procedure AddStek(var w:TSel; inf:TInf);
 var t:TSel;
begin
 New(t);
 t^.inf:=inf;
 t^.a:=w;
 w:=t;
end;

Procedure ReadStek(w:TSel; n:integer; var inf:Tinf);
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

Procedure DelLast(var w:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w=nil then exit;
 inf:=w^.inf;
 t:=w;
 w:=w^.a;
 dispose(t);
end;

Procedure DelAfterStek(sp:TSel; var inf:Tinf);
 var t:TSel;
begin
 if (sp^.a=nil) then exit;
 if sp^.a^.a=nil then
  begin
   sp^.a:=nil;
   exit;
  end;
 t:=sp^.a;
 inf:=t^.inf;
 sp^.a:=t^.a;
 dispose(t);
end;

Procedure DelStek(var w:TSel);
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

Procedure RevInf(sp:TSel);
 var inf:Tinf;
begin
 inf:=sp^.inf;
 sp^.inf:=sp^.a.inf;
 sp^.a^.inf:=inf;
end;

Procedure SortAfter(var w:TSel);
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

Procedure SortInf(w:TSel);
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

   {---------Î×ÅÐÅÄÜ---------}

Procedure AddBeg(var w1,wk:TSel; inf:Tinf);
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

Procedure AddEnd(var w1,wk:TSel; inf:Tinf);
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

Procedure AddAfter(sp:TSel; inf:Tinf);
 var t:TSel;
begin
 if sp^.a=nil then exit;
 new(t);
 t^.inf:=inf;
 t^.a:=sp^.a;
 sp^.a:=t;
end;

Procedure DelBeg(var w1,wk:TSel; var inf:Tinf);
 var t:TSel;
begin
 if w1=nil then exit;
 inf:=w1^.inf;
 t:=w1;
 w1:=w1^.a;
 dispose(t);
 if w1=nil then wk:=nil;
end;

Procedure DelAfterSpis(var w1,wk,sp:TSel; var inf:Tinf);
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

        {---------ÄÂÓÑÂßÇÍÀß Î×ÅÐÅÄÜ---------}

Procedure AddBegD(var w1,wk:Tseld; inf:Tinf);
 var t:Tseld;
begin 
 New(t);
 t^.inf:=inf;
 t^.b:=nil;
 if w1=nil then
  begin
   t^.a:=nil;
   w1:=t;
   wk:=t;
  end
 else
  begin
   t^.a:=w1;
   w1^.b:=t;
   w1:=t;
  end;
end;

Procedure AddEndD(var w1,wk:Tseld; inf:Tinf);
 var t:Tseld;
begin
 New(t);
 t^.inf:=inf;
 t^.a:=nil;
 if wk=nil then
  begin
   t^.b:=nil;
   w1:=t;
   wk:=t;
  end
 else
  begin
   t^.b:=wk;
   wk^.a:=t;
   wk:=t;
  end;
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
 if w1=wk then
  begin
   w1:=nil;
   wk:=nil;
  end
 else
  begin
   w1^.a^.b:=nil;
   w1:=w1^.a;
  end;
 Dispose(t);
end;

Procedure DelEndD(var w1,wk:Tseld; var inf:Tinf);
 var t:Tseld;
begin
 if wk=nil then exit;
 inf:=wk^.inf;
 t:=wk;
 if w1=wk then
  begin
   w1:=nil;
   wk:=nil;
  end
 else
  begin
   wk^.b^.a:=nil;
   wk:=wk^.b;
  end;
 Dispose(t);
end;

Procedure DelD(var w1,wk,sp:Tseld; var inf:Tinf);
begin
 if sp=nil then exit;
 if sp^.a=nil then
  begin
   delendD(w1,wk,inf);
   exit;
  end;
 if sp^.b=nil then
  begin
   DelBegD(w1,wk,inf);
   exit;
  end;
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

Procedure WrtBegD(w1:Tseld; s:TMemo);
 var t:Tseld;
begin
 t:=w1;
 s.clear;
 while t<>nil  do
  begin
   s.lines.add(IntToStr(t^.inf));
   t:=t^.a;
  end;
end;

Procedure WrtEndD(wk:Tseld; s:TMemo);
 var t:Tseld;
begin
 t:=wk;
 s.clear;
 while  t<>nil  do
  begin
   s.lines.add(IntToStr(t^.inf));
   t:=t^.b;
  end;
end;

Procedure slipD (var sq1,sqk,sr1,srk,sp1,spk:TSeld);
 var  infq,infr:Tinf;
begin
 sp1:=nil;   spk:=nil;
 while (sq1<>nil) and (sr1<>nil) do
  begin
   DelBegD(sq1,sqk,infq);
   DelBegD(sr1,srk,infr);
   if infq<infr then
    begin
     AddEndD(sp1,spk,infq);
     AddBegD(sr1,srk,infr);
    end
   else
    begin
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

Procedure div2s(var sp1,spk,sq1,sqk,sr1,srk:TSeld);
 var inf:Tinf;
begin
 sr1:=nil;  srk:=nil;
 sq1:=nil;  sqk:=nil;
 while sp1<>nil do
  begin
   DelBegD(sp1,spk,inf);
   AddEndD(sq1,sqk,inf);
   if sp1<>nil then
    begin
     DelBegD(sp1,spk,inf);
     AddEndD(sr1,srk,inf);
    end;
  end;
end;

Procedure sortslD(var w1,wk:TSeld);
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

end.
