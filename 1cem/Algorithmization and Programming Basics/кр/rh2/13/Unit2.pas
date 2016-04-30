unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  tfl = file of char;

  function calc(const fl : tfl; x : Char) : longint;

implementation

function calc;
var
  count : longint;
  c : char;
begin
  Reset(fl);
  count := 0;
  while not(Eof(fl)) do begin
    read(fl,c);
    if c = x then inc(count);
  end;
  calc := count;
end;

end.
 