unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  fun = function(x : Extended) : Extended;
  function solve(a,b : Extended; n : LongInt; f : fun) : Extended;

implementation

function solve;
var
  i : LongInt;
  cx,H,ans : Extended;
begin
  h := (b - a) / n;
  ans := 0;
  cx := a - h/2;
  for i := 1 to n do begin
    cx :=cx + h;
    ans := ans + h * f(cx);
  end;
  solve := ans;
end;

end.
 