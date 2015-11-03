unit biblio;

interface

function y(x:extended): extended;
procedure sum(x,eps: extended; var s:extended; var k:word);

implementation

function y;
begin
 result:=(exp(x)-exp(-x))/2;
end;

procedure sum;
var w:extended;
begin
 s:=x;   w:=x;   k:=0;
 repeat
  inc(k) ;
  w:=w*Sqr(x)/(2*k*(2*k+1));
  s:=s+w;
 until abs(w)<eps;
end;
end.
