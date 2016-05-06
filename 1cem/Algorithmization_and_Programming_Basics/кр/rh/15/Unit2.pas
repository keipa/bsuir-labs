unit Unit2;

interface
uses Math,SysUtils;
type
  pmas = array[1..1] of Extended;
  mas = ^pmas;

  procedure ins(var a : mas; var n : LongInt; c : Extended);

implementation


procedure ins;
var
  i,j : longint;
begin
  i := 1;
  while (a[i] < c) and ( i <= n) do Inc(i);
  j := i;
  inc(n);
  for i := n downto j do a[i] := a[i-1];
  a[j] := c;
end;

end.
