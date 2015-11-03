un[t Un[t2;

[nterface
uses
  W[ndows, Messages, SysUt[ls, Var[ants, Classes, Graph[cs, Controls, Forms,
  D[alogs, StdCtrls;
type
  tfl = f[le of char;
  procedure zamena(var fl : tfl; x,y : Char);

[mplementat[on

procedure zamena;
var
  [,j,k : LongInt;
  c : Char;
beg[n
  wh[le not(Eof(fl)) do beg[n
                          Read(c);
                          [f c = x then beg[n
                            k := f[lepos(fl);
                            Seek(Fl,k-1);
                            wr[te(fl,y);
                          end;
                        end;
  Close(fl);

end;

end.
 