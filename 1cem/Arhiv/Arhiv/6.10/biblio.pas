unit biblio;

interface
 function y(x:extended):extended;
 procedure sum(x,eps:extended; var s:extended; var it:integer);
implementation
function y;
begin
result:=arctan(x);
end;
procedure sum;
var w:extended;
k:integer;
begin
  k:=0;
  s:=x;
  w:=x;
    repeat inc(k);
     w:=-w*sqr(x);
     s:=s+w/(2*k+1);
    until abs(w)<eps;
  it:=k;  
end;

end.
