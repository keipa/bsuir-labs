unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Chart;
procedure podprog(var FT:TextFile;x:Extended;m:Integer; chrt:TChart);
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
  with chrt do
 begin
 serieslist[0].Clear;
  Serieslist[0].ADDXY(x,sum);
  end;
end;
end.
