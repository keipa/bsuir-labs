unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
  procedure solve(st : string; memo : TMemo);

implementation

procedure solve;
var
  curs : string;
  x,i,j : LongInt;
begin
  curs := '';
  st := st + ' ';
  for i := 1 to Length(st) do begin
    if (st[i] = ' ') then begin
      x := 1;
      if curs <> '' then x := StrToInt(curs);
      if Not Odd(x) then memo.Lines.Add(curs);
      curs := '';
    end
    else curs := curs + st[i];
  end;
end;

end.
 