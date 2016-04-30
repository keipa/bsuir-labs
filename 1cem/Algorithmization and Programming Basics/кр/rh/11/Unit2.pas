unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  fun = function ( x : Extended) : extended;
procedure tabl(a,b : Extended; n : longint; f : fun; mem1 : TMemo);

implementation

procedure tabl;
var
  cx,h,res : extended;
  i : LongInt;
begin
  h := (b - a) / n;
  cx := a - h ;
  for i :=0 to n do begin
    cx := cx + h;
    res := f(cx);
    mem1.lines.add(FloatToStrF(res,ffFixed,8,3));
  end;
end;

end.
 