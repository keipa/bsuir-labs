unit Unit2;

interface
uses math;
type
  fun = function(x : Extended) : extended;
  function fmin(a,b,h : Extended; f : fun) : Extended;

implementation

function fmin;
var
  cx,cf : Extended;
  res : Extended;
begin
  cx := a;
  res := sqr(b);
  while cx <= b do begin
    cf := f(cx);
    res := min(res,cf);
    cx := cx + h;
  end;
  fmin := res;
end;

end.
 