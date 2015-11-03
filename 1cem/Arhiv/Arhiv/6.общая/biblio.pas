unit biblio;

interface

function y(x:extended):extended;
procedure sum(x,eps:extended; var s:extended; var k:word);

implementation

function y;
 begin
  result:=exp(-x);
 end;

procedure sum;
var w:extended;
begin
 s:=1;
 w:=1;
 k:=0;
 repeat
  inc(k);
  w:=-w*x/k;
  s:=s+w;
 until abs(w)<eps;
end;

end.
