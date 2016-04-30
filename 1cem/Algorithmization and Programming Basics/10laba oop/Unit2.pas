unit Unit2;

interface
uses Graphics;
var ColrBack:TColor;
type
  TWheelMove = class(Tobject)
   ColrLine : Tcolor;
   Canvas:TCanvas;
   x, y, r : word;
    Procedure Ris;virtual;
    Procedure Draw(bl:boolean);
    procedure Show;
    procedure Hide;
    procedure MovTo(dx,dy,dr:integer);
    Constructor Create(x0,y0,r0:word; colrLine0:Tcolor; canvas0:TImage);
    end;

  TWheelRotate = class(TWheelMove)
  procedure rotate(bl:boolean);
  Procedure Ris; override;
  end;

implementation

Constructor TWheelmove.Create;
 begin

   x:=x0; y:=y0; r:=r0;
   colrLine:=colrLine0;
   img1:=canvas0;
 end;


Procedure TWheelmove.Draw;
 begin
   with canvas do begin
     if bl then begin
       pen.color:=colrLine; brush.color:=colrLine
      end
       else begin
         pen.color:=colrBack; brush.color:=colrBack
       end;
       Ris;
   end;
 end;


Procedure TWheelmove.Show;
  begin
   Draw(true);
  end;


Procedure TWheelmove.Hide;
  begin
    Draw(false);
  end;

procedure TWheelmove.MovTo;
  begin
   Hide;
   x:=x+dx; y:=y+dy; r:=r+dr;
   Show;
  end;


 Procedure TWheelmove.Ris;
   Begin
     x1:=x-r; x2:=x+r; y1:=y-r; y2:=y+r;
     img1.Ellipse(x1,y1,x2,y2);
   end;

 Procedure TWheelRotate.rotate;
 begin 
 Inherited ris
 with img1 do begin

      if bl then begin
       moveto(x,y); lineto(x1,y);
       moveto(x,y); lineto(x2,y);
      end else begin
       moveto(x,y); lineto(x,y1);
       moveto(x,y); lineto(x,y2);
      end;

     end;
 end; 



 end.

 