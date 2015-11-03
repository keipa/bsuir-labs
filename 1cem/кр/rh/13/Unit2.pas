unit Unit2;

interface
uses math,SysUtils;
type
  pmas = array[1..1] of extended;
  mas = ^pmas;

function find(a : mas; n : LongInt; bm : Boolean) : extended;

implementation

function find;
var
  i : LongInt;
  res : extended;
begin
  res := 0;
  res := a[1];
  for i:= 1 to n do if bm then res := min(res,a[i]) else res := Max(res,a[i]);
  find := res;
end;

end.
 