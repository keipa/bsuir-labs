unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  tmas = array[1..1] of Extended;
  pmas = ^tmas;
  procedure merge_sort(a,b : pmas; n,m : LongInt; var c : pmas);

implementation

procedure merge_sort;
var
  i,j,k : longint;
begin
  i := 1;
  j := 1;
  k := 0;
  while k < n+m do begin
     if i = n+1 then begin
       Inc(k);
       c[k] := b[j];
       Inc(j);
     end
     else
     if j = m+1 then begin
       Inc(k);
       c[k] := a[i];
       Inc(i);
     end
     else begin
       if a[i] < b[j] then begin
         Inc(k);
         c[k] := a[i];
         Inc(i);
       end
       else begin
         Inc(k);
         c[k] := b[j];
         Inc(j);
       end;
     end;
  end;

end;

end.
 