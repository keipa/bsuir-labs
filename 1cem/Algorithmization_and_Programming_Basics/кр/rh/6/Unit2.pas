unit Unit2;

interface
uses math,SysUtils;

function ok( n : LongInt ) : Boolean;

implementation

function ok;
var
  c1,c2,c3 : longint;
begin
  c3 := n mod 10;
  c2 := (n div 10) mod 10;
  c1 := n div 100;
  ok := ( ( c1 = c2) and (c1 <> c3)) or ( (c1 = c3) and (c1 <> c2)) or ( ( c2 = c3) and(c1 <> c2));
end;

end.
 