unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

function calculate(st : string) : LongInt;

implementation

function calculate;
var
  mn : Set of Char;
  i,count : LongInt;
begin
  mn := [];
  count := 0;
  for i := 1 to Length(st) do if not( st[i] in mn) then begin
    mn := mn + [st[i]];
    Inc(count);
  end;
  calculate := count;
end;

end.
 