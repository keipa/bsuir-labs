unit biblio;

interface

function y(x:extended):extended;
procedure sum(x,eps:extended; var s:extended; var k:word);

implementation

function y;
begin
 result:=x*arctan(x)-ln(sqrt(1+sqr(x)));
end;

procedure sum;
var w:extended;
begin
 w:=-1;
 s:=0;
 k:=0;
 repeat
  inc(k);
  w:=-w*sqr(x);
  s:=s+w/(2*k*(2*k-1));
 until abs(w)<eps;
end;

end.
