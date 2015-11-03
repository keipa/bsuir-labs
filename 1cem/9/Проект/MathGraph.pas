unit MathGraph;

interface
  uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, Clipbrd,
  TeEngine, Series, TeeProcs, Chart;

  Type
  fun=function(x:extended):extended;
  procedure Graph(f:fun;xn,xk:extended;m:integer;Chart1:TChart);
  procedure IGraph(f:fun;xn,xk,xsc,ysc:extended;y0,m:integer;Image2:TImage);
implementation
  procedure Graph;
    var
      x,y,h:extended;
      i:integer;
    begin
      x:=xn;
      h:=(xk-xn)/m;
        for i:=1 to m do
          begin
            y:=f(x);
            Chart1.SeriesList[0].AddXY(x,y);
            x:=x+h;
          end;  
    end;
  procedure IGraph;
    var
      x,y,h:extended;
      i:integer;
    begin
      h:=(xk-xn)/m;
      x:=xn;
      y:=f(x);
        Image2.Canvas.MoveTo(Round(x/xsc),Round(y0-y/ysc));
      for i:=1 to m do
        begin
          x:=x+h;
          y:=f(x);
          Image2.Canvas.LineTo(Round(x/xsc),Round(y0-y/ysc));
        end;
    end;
end.

