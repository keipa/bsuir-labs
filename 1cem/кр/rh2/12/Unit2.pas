unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  tfl = file of char;
  procedure zamena(var fl : tfl; x,y : Char);

implementation

procedure zamena;
var
  i,j,k : LongInt;
  c : Char;
begin
  while not(Eof(fl)) do begin
                          Read(fl,c);
                          if c = x then begin
                            k := filepos(fl);
                            Seek(Fl,k-1);
                            write(fl,y);
                          end;
                        end;
  Close(fl);

end;

end.
 