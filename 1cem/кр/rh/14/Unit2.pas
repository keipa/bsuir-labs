unit Unit2;

interface
uses math,SysUtils;
type
  pmas = array[1..1] of extended;
  mas = ^pmas;
procedure find(var a : mas; n : LongInt);

implementation

procedure swap(var a,b : Extended);
var
  c : Extended;
begin
  c :=a;
  a := b;
  b := c;
end;

procedure find;
var
  i,j: LongInt;
begin
  for i := 1 to n-1 do
    for j := i +1 to n do if a[i] > a[j] then swap(a[i],a[j]);
end;

end.
