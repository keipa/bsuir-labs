unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
procedure podprog(var FT:TextFile;x:Extended;m:Integer);
implementation
procedure podprog;
var
k:Integer;
fun,sum:Extended;
begin
fun:=1;
sum:=0;
  for k:=1 to m do begin
  fun:=fun*x/k;
  sum:=sum+fun
  end;
  writeln(ft,'X = '+floattostrf(x,ffFixed,8,3) +' summa  = '+floattostrf(sum,ffFixed,8,3));

end;
end.
