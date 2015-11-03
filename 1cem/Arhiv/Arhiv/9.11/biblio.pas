unit biblio;

interface

function yf(x:extended):extended;
procedure sum(x,eps:extended; var s:extended);

implementation

function yf;
 begin
  result:=(1-sqr(x)/2)*cos(x)-(x/2)*sin(x);
 end;

procedure sum;
var w:extended;
 k: word;
begin
 s:=1;
 w:=1;
 k:=0;
 repeat
  inc(k);
  w:=-w*sqr(x)/(2*k*(2*k-1));
  s:=s+w*(2*sqr(k)+1);
 until abs(w)<eps;
end;

end.
