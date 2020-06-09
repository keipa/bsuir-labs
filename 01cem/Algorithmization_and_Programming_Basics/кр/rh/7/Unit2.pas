unit Unit2;

interface
uses math,SysUtils;

function find( n : LongInt ) : LongInt;

implementation

function find;
var
  res,q,a,b : LongInt;
begin
  a := n;
  q := 1;
  b := n mod 10;
  while a > 9 do begin
    q := q * 10;
    a := a div 10;
  end;
  find := q * b + n - a*q  - b + a;
end;

end.
