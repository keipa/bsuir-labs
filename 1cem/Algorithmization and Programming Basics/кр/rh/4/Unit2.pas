unit Unit2;

interface
uses SysUtils,Math;
type
  mas = array of Extended;

function find(const x : Extended; n : LongInt; a : mas) : extended;

implementation

function find;
var
  i : longint;
  res,px : Extended;
begin
  res := a[n];
  for i := n-1 downto 0 do res := res * x + a[i];
  find := res;
end;

end.
 