unit Unit2;

interface
uses Math,SysUtils;
function find(const x,e : Extended) : Extended;

implementation

function find;
var
  res,a : Extended;
  count : longint;
begin
  res := 0;
  a := 1;
  count := 0;
  while Abs(a) > e do begin
    Inc(count);
    a := -a * x / count;
    res := res + a;
  end;
  Find := res;

end;

end.
 