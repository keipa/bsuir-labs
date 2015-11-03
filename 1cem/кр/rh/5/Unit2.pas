unit Unit2;

interface
uses Math,SysUtils;

function find(const n : longint; bl : Boolean ) : LongInt;

implementation

function find;
var
  res : LongInt;
  a : LongInt;
begin
  a := n;
  if bl then res := 0 else res := 1;
  while a > 0 do begin
    if bl then Inc(res, a mod 10) else res := res * ( a mod 10);
    a := a div 10;
  end;
  find := res;
end;

end.
 