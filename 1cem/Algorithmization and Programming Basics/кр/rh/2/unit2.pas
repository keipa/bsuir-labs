unit Unit2;

interface
uses math,SysUtils;
  function find(const x0,x1,e : Extended; var p : LongInt) : Extended;

var
  a : Extended;



implementation


function f( x : Extended) : extended;
begin
  f := Sqr(x) - a;
end;

function find;
var
  count : longint;
  a0,a1,a2,d : Extended;
begin
  a0 := x0;
  a1 := x1;
  count := 0;
  repeat
    Inc(count);
    a2 := a1 - ( f(a1) * ( a1 - a0)) / (f(a1) - f(a0));
    d := Abs(a2 - a1);
    a0 := a1;
    a1 := a2;
  until (d < e) or (count > 10);
  if count = 11 then p := 0
  else begin
    p := count;
    find  := a2;
  end;
end;



end.
 