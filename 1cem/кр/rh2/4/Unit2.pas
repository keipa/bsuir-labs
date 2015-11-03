unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart;
type
  fun = function( x : Extended) :Extended;
  procedure draw(a,b : Extended; n : LongInt; f : fun; im : TImage);

implementation

procedure draw;
var
  i : longint;
  q,cx,h : Extended;
begin
  cx := a;
  h := (b - a) / n;
  for i := 1 to n+1 do begin
    q := f(cx);
    cx := cx + h;
  end;
end;

end.
 