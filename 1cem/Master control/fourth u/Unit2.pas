unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
  procedure graph(var a,b,n,x,y:Integer;im:TImage);
var
  m:Integer;
  xmin:integer;
  xmax:integer;
  ymin:integer;
  ymax:integer;
implementation
    procedure graph;
    begin
    with im.canvas do begin
      Pen.Width := 2;
      MoveTo(20,ymax-20);
      LineTo(30,50);
    end;
end;
end.
 