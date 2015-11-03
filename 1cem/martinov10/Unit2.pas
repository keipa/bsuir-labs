unit Unit2;
interface

uses Graphics;

var ColrBack:TColor;

type
 Tpram=class
  ColrLine:TColor;
  Canvas:TCanvas;
  x,y,r,x1,y1,x2,y2,r0:word;
  Procedure Ris;virtual;
  Procedure Draw(bl:boolean);
  Procedure Show;
  Procedure Hide;
  Procedure MovTo(dx,dy,dr:integer);
  Constructor Create(x0,y0,r0:word;colrLine0:TColor;canvas0:TCanvas);
 end;
 Tkrug=class(Tpram)
  Procedure Ris;override;
 end;

implementation

Procedure Tpram.Draw;
begin
 with Canvas do
  begin
   if bl then
    begin
     Pen.Color:=colrLine;
     Brush.Color:=colrLine;
    end
   else
    begin
     Pen.Color:=colrBack;
     Brush.Color:=colrBack;
    end;
   Ris;
  end;
end;

Procedure Tpram.Show;
begin
 Draw(True);
end;

Procedure Tpram.Hide;
begin
 Draw(False);
end;

Procedure Tpram.MovTo;
begin
 Hide;
 x:=x+dx;
 y:=y+dy;
 r:=r+dr;
 Show;
end;

Constructor Tpram.Create;
begin
 colrLine:=colrLine0;
 canvas:=canvas0;
 x:=x0;
 y:=y0;
 r:=r0
end;

Procedure Tpram.Ris;
begin
 x1:=x-2*r;
 x2:=x+2*r;
 y1:=y-r;
 y2:=y{+r};
 Canvas.Rectangle(x1,y1,x2,y2);
end;

Procedure Tkrug.Ris;
begin
 x1:=x-r;
 x2:=x+r;
 y1:=y-r;
 y2:=y+r;
 Canvas.Ellipse(x1,y1,x2,y2);
end;
end.
