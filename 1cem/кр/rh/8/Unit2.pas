unit Unit2;

interface
uses math,SysUtils;
function find( N : LongInt) : LongInt;
implementation

function find;
var
  a: LongInt;
  ost,res : LongInt;
begin
  a := n;
  res := 0;
  while a > 0 do begin
    ost := a mod 10;
    res := res*10 + ost;
    a := a div 10;
  end;
  find := res;
end;


end.
 