unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

Type  PSel=^TSel;
      TSel=record
		    Inf:integer;
		    last,next:PSel;
		  end;
      TList = class(Tobject)
        sp1,spk,sp,sr:PSel;
        b1,bk:boolean;
        N0:integer;
        constructor create;
        procedure AddFFirst(inf:integer);
        procedure AddFLast(inf:integer);
        procedure ReadFLast(var inf:integer);
        procedure ReadFFirst(var inf:integer);
        procedure PrintFFirst(M:TMemo);
        procedure PrintFLast(M:TMemo);
        procedure AddBefore(inf:integer; N:integer);
        procedure AddAfter(inf:integer; N:integer);
        procedure Size;
        procedure SearchAndChange(var sp1:Psel);
	    end;
      procedure SortSlip(var tp:TList);
      procedure Div2SP(var tp,tq,tr:TList);
implementation

constructor TList.Create;
begin
  Inherited create;
  New(sp1);
  New(spk);
  sp1:=Nil;
  spk:=Nil;
end;

procedure TList.AddFFirst;
begin
  New(sp);
  sp.Inf:=inf;
  sp^.next:=Nil;
  sp^.last:=Nil;
  if sp1=Nil then
    begin
      sp1:=sp;
      spk:=sp;
    end
  else
    begin
      sp^.next:=sp1;
      sp1^.last:=sp;
      sp1:=sp;
    end;
end;

procedure TList.AddFLast;
begin
  New(sp);
  sp.inf:=inf;
  sp^.next:=Nil;
  sp^.last:=Nil;
  if sp1=Nil then
    begin
      sp1:=sp;
      spk:=sp;
    end
  else
    begin
      spk^.next:=sp;
      sp^.last:=spk;
      spk:=sp;
    end;
end;

procedure TList.ReadFFirst;
begin
  if spk=Nil then
    begin
      ShowMessage('Список пуст');
      b1:=false;
    end
  else
    begin
      b1:=true;
      if spk<>sp1 then
        begin
          sp:=sp1;
          inf:=sp^.inf;
          sp^.next^.last:=Nil;
          sp1:=sp^.next;
          Dispose(sp);
        end
      else
        begin
          sp:=spk;
          inf:=spk.inf;
          sp1:=Nil;
          spk:=Nil;
        end;
    end;
end;

procedure TList.ReadFLast;
begin
  if sp1=Nil then
    begin
      ShowMessage('Список пуст');
      bk:=false;
    end
  else
    begin
      bk:=true;
      if spk<>sp1 then
        begin
          sp:=spk;
          inf:=sp^.inf;
          sp^.last^.next:=Nil;
          spk:=sp^.last;
          Dispose(sp);
        end
      else
        begin
          sp:=sp1;
          inf:=sp1.inf;
          sp1:=Nil;
          spk:=Nil;
        end;
    end;
end;

procedure TList.Size;
begin
  N0:=0;
  sp:=sp1;
  while sp<>Nil do
    begin
      sp:=sp^.next;
      Inc(N0);
    end;
end;

procedure TList.AddAfter;
var k:integer;
    spi:PSel;
begin
  if N=0 then
    AddFFirst(inf);
  if N=N0 then
    AddFLast(inf)
  else
    begin
      if N<0 then
        ShowMessage('Введите N>=0');
      if N>N0 then
        ShowMessage('Введите N<='+IntToStr(N0));
      if (N>0) and (N<N0) then
        if sp1=Nil then
          ShowMessage('Список пуст')
        else
          begin
            k:=1;
            spi:=sp1;
            while (k<>N) and (spi<>Nil) do
              begin
                spi:=spi^.next;
                Inc(k);
              end;
            New(sp);
            sp^.Inf:=Inf;
            sp^.last:=spi;
            sp^.next:=spi.next;
            spi^.next:=sp;
            sp^.next^.last:=sp;
          end;
    end;
end;

procedure TList.AddBefore;
var k:integer;
    spi:PSel;
begin
  if N=1 then
    AddFFirst(inf);
  if N=N0+1 then
    AddFLast(inf)
  else
    begin
      if N<1 then
        ShowMessage('Введите N>=1');
      if N>N0+1 then
        ShowMessage('Введите N<='+IntToStr(N0+1));
      if (N>1) and (N<N0+1) then
        if sp1=Nil then
          ShowMessage('Список пуст')
        else
          begin
            k:=1;
            spi:=sp1;
            while (k<>N) and (spi<>Nil) do
              begin
                spi:=spi^.next;
                Inc(k);
              end;
            New(sp);
		        sp^.Inf:=Inf;
		        sp^.next:=spi;
		        sp^.last:=spi.last;
		        spi^.last:=sp;
		        sp^.last^.next:=sp;
          end;
    end;
end;

procedure TList.PrintFLast;
begin
  if spk<>Nil then
    begin
      M.Lines.Add(IntToStr(spk.inf));
      sp:=spk;
      while sp^.last<>Nil do
        begin
          M.Lines.Add(IntToStr(sp^.last.inf));
          sp:=sp^.last;
        end;
    end;
end;

procedure TList.PrintFFirst;
begin
  if sp1<>Nil then
    begin
      M.Lines.Add(IntToStr(sp1.inf));
      sp:=sp1;
      while sp^.next<>Nil do
        begin
          M.Lines.Add(IntToStr(sp^.next.inf));
          sp:=sp^.next;
        end;
    end;
end;

procedure Div2SP;
var Inf:integer;
    bl:boolean;
begin
  tq:=Tlist.create;
  tr:=Tlist.create;
  bl:=true;
  while bl do
    begin
      tp.ReadFFirst(Inf);
      tq.AddFLast(Inf);
      bl:=(tp.sp1<>Nil);
      if bl then
        begin
          tp.ReadFFirst(Inf);
          tr.AddFLast(Inf);
          bl:=(tp.sp1<>Nil);
        end;
    end;
end;

procedure SortSlip;
  procedure Slip(var tq,tr,tp:TList);
  var Inf:integer;
  begin
    tp:=TList.Create;
    while (tq.sp1<>Nil) and (tr.sp1<>Nil) do
      if tq.sp1.Inf<tr.sp1.Inf  then
        begin
          tq.ReadFFirst(Inf);
          tp.AddFLast(Inf);
        end
      else
        begin
          tr.ReadFFirst(Inf);
          tp.AddFLast(Inf);
        end;
    while tq.sp1<>Nil do
      begin
        tq.ReadFFirst(Inf);
        tp.AddFLast(Inf);
      end;
    while tr.sp1<>Nil do
      begin
        tr.ReadFFirst(Inf);
        tp.AddFLast(Inf);
      end;
  end;
var tq,tr:Tlist;
begin
  if tp.sp1<>tp.spk then
    begin
      Div2sp(tp,tq,tr);
      SortSlip(tq);
	    SortSlip(tr);
	    Slip(tq,tr,tp);
    end;
end;

procedure TList.SearchAndChange;
var
  min,max,tmp,tmp1:PSel;
  k:integer;
begin
  min:=sp1;
  max:=sp1;
  tmp1:=sp1;
    while tmp1^.next <> nil do
      begin
        tmp:=tmp1^.next;
          if tmp^.inf > max^.inf then
             max:=tmp;
          if tmp^.inf < min^.inf then
             min:=tmp;
        tmp1:=tmp1^.next;
      end;
  k:=min^.inf;
  min^.inf:=max^.inf;
  max^.inf:=k;
end;

end.
