unit Unit2;
interface
uses 
  StdCtrls, SysUtils;

  function yx(x:extended):extended;
  function ys(x:extended):extended;


implementation



function yx(x:extended):extended ;
 var
  e,a,s:real;
  n:integer;

begin

  a:=X;
  s:=a;
  n:=0;
    while (abs(a)>e) do
      begin
        n:=n+1;
        a:=(-1)*a/((2*n)*(2*n+1));
     //   a:=a*(-1)*(x*x)/((2*n)*(2*n+1));
        s:=s+a;
      end;
   yx:=s;

end;

function ys(x:extended):extended;
var y:extended;
begin

y:=sin(x);
ys:=y;

end;

end.
 
