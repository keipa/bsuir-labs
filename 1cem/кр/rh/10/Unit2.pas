unit Unit2;
interface
uses
  SysUtils, StdCtrls;
type
  pmas = array[1..1] of LongInt;
  mas  = ^ pmas;

  procedure calculate( size : LongInt; var nsize : LongInt;  a : mas);

implementation

procedure calculate;
var
  i,j : LongInt;
begin
  j := 0;
  for i := 1 to size do  if Odd(a[i]) then begin
    Inc(j);
    a[j] := a[i];
  end;
  Nsize := j;
end;

end.
 