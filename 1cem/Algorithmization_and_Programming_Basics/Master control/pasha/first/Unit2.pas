unit Unit2;

interface

procedure sort(var a:array of integer;var n:integer);
procedure sdvig(var a:array of integer;var ind:integer;var elval:integer; var n:integer);


implementation


procedure sort(var a:array of integer;var n:integer);
var i,j,r:integer;
begin
    for i:=0 to n-1 do
     for j:=0 to n do
       if a[i]> a[j]then
       begin
         r:=a[i];                                       //sorting
         a[i]:=a[j];
         a[j]:=r;
       end;
end;

procedure sdvig(var a:array of integer;var ind:integer;var elval:integer; var n:integer);
var i:Integer;
begin

 for i:=n  downto  ind+1 do
 begin                                                  //sdvig
   a[i]:=a[i-1];
   end;

  a[ind-1] := elval;



end;



end.
