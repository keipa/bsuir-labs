unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;
type
  tmas = array[0..0] of Extended;
  pmas = ^tmas;
  procedure insert(var a : pmas; n : LongInt);
var
  c : Extended;

implementation

procedure insert;
var
  j,i : longint;
begin
  i := 1;
  while (i <= n) and (a[i] < c) do inc(i);
  j := i;
  for i := N+1 downto j+1 do a[i] := a[i-1];
  a[j] := c;
end;
end.
