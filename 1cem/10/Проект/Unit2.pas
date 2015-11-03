unit Unit2;

interface
  uses Graphics;
  var ColrBack:TColor;
  Type
    TViz = class (TObject)
     ColrLine:TColor;
     Canvas:TCanvas;
     x,y,r,d:word;
     Procedure Ris; virtual; abstract;
     Procedure Draw(bl:boolean);
     Procedure Show;
     Procedure Hide;
     Procedure MovTo(dx,dy,dr:integer);
    end;
    TPr = class (TViz)       //основа
      x1,y1,x2,y2:word;
      Constructor Create(x0,y0,r0,d0:word;ColrLine0:TColor;Canvas0:TCanvas);
      Procedure Ris; override;
      Procedure dim;
    end;

implementation
  Procedure TViz.Draw;
    begin
      with Canvas do begin
        if bl then begin pen.color:=colrLine; brush.color:=colrLine; end
              else begin pen.color:=colrBack; brush.color:=colrBack; end;
        Ris;
      end;
    end;
  Procedure TViz.Show;
    begin
      Draw(True);
    end;
  Procedure TViz.Hide;
    begin
      Draw(False);
    end;
  Procedure TViz.MovTo;
    begin
      Hide;
      x:=x+dx; y:=y+dy; r:=r+dr; d:=d+dr;
      Show;
    end;

  Constructor TPr.Create;
    begin
      colrLine:=colrLine0;
      canvas:=canvas0;
      x:=x0; y:=y0; r:=r0; d:=d0;
    end;

  Procedure TPr.Ris;
    begin
      x1:=x-r; x2:=x+r; y1:=y-d; y2:=y+d;
      with Canvas do
        begin
            Rectangle(x1,y1,x2,y2);
            Rectangle(x1+15,y2,x1+75,y2+15);
            Rectangle(x2-15,y2,x2-75,y2+15);
            Rectangle(x,y1,x2,y1-50);
            Rectangle(x1+20,y1-50,x1+50,y1);
        end;
    end;

  Procedure TPr.Dim;
  var x1,x2,y1,y2:integer;
  begin
  x1:=x-r+24; x2:=x-r+46; y1:=y-d-60; y2:=y-d-80;
      Canvas.Ellipse(x1,y1,x2,y2);
   end;
end.
