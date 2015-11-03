unit Unit2;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids;
Type
 TElem = Record
  c,w:Extended;
 end;

 TMetod = Class(TObject)
  n:Byte;
  a: array [1..100] of TElem;
  s,optS:Set of byte;
  Wmax,Cmax,oct1:Extended;
  Procedure PP(I:word; Tw,Oct:extended);  // полный перебор
  Procedure VG(I:word; Tw,Oct:Extended);  // ветвей и границ
  Procedure MS;                           // максимальной стоимости
  Procedure MW;                           // максимального веса
  Procedure SS;                           // сбалансированной стоимости
  Procedure SP;                           // случайного поиска
 end;
 
implementation

  Procedure TMetod.VG;
	begin
	  if tw+a[i].w<=Wmax then
    begin
		  Include(s,i);
		  if i<n then VG(i+1,tw+a[i].w,oct)
 	           else
      if oct>Cmax then begin
              Cmax:=oct;
              optS:=S
                       end;
      Exclude(S,i);
    end;
    oct1:=oct-a[i].c;
	  if oct1>Cmax then
	  	 if i<n then VG(i+1,tw,oct1)
                 else begin
                        Cmax:=oct1;
                        optS:=S
                      end;
	End;

Procedure TMetod.PP;
  begin
    Include(s,i);
    tw:=tw+a[i].w;
    oct:=oct+A[i].c;
  if i<n then PP(i+1,tw,oct)
         else if (tw<=Wmax) and (oct>Cmax) then
                   begin Cmax:=oct; optS:=S;end;
    Exclude(s,i);
    tw:=tw-a[i].w;
    oct:=oct-A[i].c;
  if i<n then PP(i+1,tw,oct)
         else if (tw<=Wmax) and (oct>Cmax) then
                    begin Cmax:=oct; optS:=S;end;
   End;

Procedure TMetod.MS;
var
  j,k,stmp:integer;
  w:extended;
  tmp:TElem;
  s1:array [1..30] of byte;
  b:array [1..30] of TElem;
begin
    w:=0;
    for j:=1 to n do begin s1[j]:=j; b[j]:=a[j]; end;
    for j:=1 to n-1 do
      for k:=1 to n-1 do
        if b[k].c<b[k+1].c then
          begin
            tmp:=b[k]; stmp:=s1[k];
            b[k]:=b[k+1]; s1[k]:=s1[k+1];
            b[k+1]:=tmp;  s1[k+1]:=Stmp;
          end;
    For j:=1 to n do
      begin
        W:=W+b[j].w;
        if w<=wmax then
         begin
         Cmax:=Cmax+b[j].c;
         include(s,s1[j]);
         end;
      end;
    optS:=s;
  end;

Procedure TMetod.MW;
var
  j,k,stmp:integer;
  w:extended;
  tmp:TElem;
  s1:array [1..30] of byte;
  b:array [1..30] of TElem;
begin
    w:=0;
    for j:=1 to n do begin s1[j]:=j; b[j]:=a[j]; end;
    for j:=1 to n-1 do
      for k:=1 to n-1 do
        if b[k].w>b[k+1].w then
          begin
            tmp:=b[k]; stmp:=s1[k];
            b[k]:=b[k+1]; s1[k]:=s1[k+1];
            b[k+1]:=tmp;  s1[k+1]:=Stmp;
          end;
    For j:=1 to n do
      begin
        W:=W+b[j].w;
        if w<=wmax then
         begin
         Cmax:=Cmax+b[j].c;
         include(s,s1[j]);
         end;
      end;
    optS:=s;
  end;

Procedure TMetod.SS;
var
  j,k,stmp:integer;
  w:extended;
  tmp:TElem;
  s1:array [1..30] of byte;
  b:array [1..30] of TElem;
begin
    w:=0;
    for j:=1 to n do begin s1[j]:=j; b[j]:=a[j]; end;
    for j:=1 to n-1 do
      for k:=1 to n-1 do
        if (b[k].c/b[k].w)<(b[k+1].c/b[k+1].w) then
          begin
            tmp:=b[k]; stmp:=s1[k];
            b[k]:=b[k+1]; s1[k]:=s1[k+1];
            b[k+1]:=tmp;  s1[k+1]:=Stmp;
          end;
    For j:=1 to n do
      begin
        W:=W+b[j].w;
        if w<=wmax then
         begin
         Cmax:=Cmax+b[j].c;
         include(s,s1[j]);
         end;
      end;
    optS:=s;
  end;

Procedure TMetod.SP;
var
  j,k:integer;
  w:Extended;
  b:array [1..30] of Telem;
begin
 w:=0;
 for j:=1 to n do begin include(s,j); b[j]:=a[j]; end;
 randomize;
 while w<=wmax do
 begin
  k:=Random(n)+1;
  if k in s then
    begin
      w:=w+b[k].w;
      if w<=wmax then
      begin
      Cmax:=Cmax+b[k].c;
      exclude(s,k);
      end;
    end;
  end;
  for j:=1 to n do if not(j in s) then include(optS,j);
end;
end.






