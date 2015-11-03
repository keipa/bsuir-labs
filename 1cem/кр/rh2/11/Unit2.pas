unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

  procedure solve(s : string; edit : TEdit);

implementation

procedure solve;
var
  i,j : LongInt;
  f : Boolean;
begin
  edit.Clear;
  j := 1;
  for i := 1 to Length(s) do if s[i] = ']' then j :=s i;
  i := Pos('[',s);
  edit.Text := '';
  for i := i+1 to j-1 do edit.Text := edit.Text + s[i];
end;

end.
 