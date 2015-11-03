program Project1;

{$APPTYPE CONSOLE}




uses
  SysUtils,
  math;

var
ST:array[1..100,1..100] of Integer;
FI:array[1..100,1..100] of Integer;
a,b,j,i,j1,i1:integer;
angle:Real;
begin
Writeln('enter massive characteristics');
Writeln('enter a');
readln(a);
Writeln('enter b');
Readln(b);
Writeln('Fill in the array:');
for j:=1 to b do begin
  for i:=1 to a do begin
  Readln(st[i,j]);

   for j1:=1 to b do begin
     for i1:=1 to a do begin
       Write(st[i1,j1]);
     end;
     Writeln;
   end;
   fi[i,j]:=st[i,j];
  end;
end;
Writeln('enter rotate angle----rotation protiv chasovoy');
Readln(angle);
angle:=angle/90;



for j:=1 to b do begin
  for i:=1 to a do begin
     FI[j,a-i+1]:=ST[i,j];

  end;

  end;

   for j1:=1 to b do begin
     for i1:=1 to a do begin
       Write(FI[i1,j1]);
     end;
     Writeln;
   end;
Readln(angle);



end.
