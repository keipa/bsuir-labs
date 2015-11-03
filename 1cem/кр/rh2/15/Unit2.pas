unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
type
  fun = function(x : Extended) : Extended;
  procedure draw(a,b : Extended; n : LongInt; f : fun; img : TImage);

implementation

procedure draw;
var
  h : Extended;
  cx,cy,hx,hy : Extended;
  xmax,ymax,i : LongInt;
begin
  xmax := img.Width;
  ymax := img.Height;
  hx := (b-a) / xmax;
  hy := (f(b) - f(a)) / ymax;
  h := (b-a) / n;
  with img.Canvas do begin
    Pen.Color := clRed;
    Pen.Width := 2;
    cx := a;
    cy := f(a);
    MoveTo(Round((cx - a)/hx), ymax - Round((cy - f(a))/hy ));
    for i := 1 to n do begin
      cx := cx + h;
      cy := f(cx);
      LineTo(Round((cx - a)/hx), ymax - Round((cy - f(a))/hy ));
    end;
  end;

end;                               

end.
