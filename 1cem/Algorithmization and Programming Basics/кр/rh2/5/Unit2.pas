unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart;
type
  cmplx = record
    r : Extended;
    im : Extended;
  end;
  fun = function( x : Extended) : cmplx;

  procedure tabl(a,b : Extended; n : LongInt; f : fun; Ch : TChart);

implementation

procedure tabl;
var
  i : longint;
  cx,h : Extended;
  q : cmplx;
begin
  with Ch do begin
    LeftAxis.Automatic := false;
    BottomAxis.Automatic := false;

    BottomAxis.Maximum := b;
    BottomAxis.Minimum := a;
    LeftAxis.Maximum := 1;
    LeftAxis.Minimum := -2;
  end;

  h := (b - a) / n;
  cx := a;
  for i := 1 to n do begin
    q := f(cx);
    ch.SeriesList[0].AddXY(Round(cx),Round(q.r));
    Ch.SeriesList[1].AddXY(Round(cx), Round(q.im));
    cx := cx + h;
  end;

end;

end.
