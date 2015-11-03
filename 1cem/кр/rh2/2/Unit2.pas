unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  fun = function(x : Extended) : Extended;
  procedure tabl(a,b: Extended; n : LongInt; f : fun; var fl : TextFile);

implementation


procedure tabl;
var
  q,cx,h : Extended;
  i : LongInt;
begin
  h := (b - a) / n;
  cx := a;
  for i := 1 to n+1 do begin
    q := f(cx);
    writeln(Fl,'x=' +floattostrf(cx,ffFixed,8,3) + ' ' + 's(x) = ' +FloatToStrF(q,ffFixed,8,3) );
    //write(fl,'1');
    cx := cx + h;
  end;
  Close(fl);


end;

end.
