unit Unit2;

interface
  function  solve(const a,e : Extended) : Extended;

implementation
function solve;
var
  d,px,cx : Extended;
begin
  px := 1;
  repeat
    cx := 0.5 * (px + a/px);
    d := Abs(px - cx);
    px := cx;
  until d < e;
  result := cx;
end;

end.
