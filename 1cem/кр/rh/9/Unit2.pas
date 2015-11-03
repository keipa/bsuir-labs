unit Unit2;

interface
uses math,SysUtils;
procedure fdk (n,m : LongInt; var dd,k : LongInt);

implementation

procedure fdk;
var
  x,y,d : LongInt;
begin
  x := Min(n,m);
  y := Max(n,m);
  d := x mod y;
  while d <> 0 do begin
    x := y;
    y := d;
    d := x mod y;
  end;
  dd := y;
  k := (n div dd) * m;
end;

end.
 