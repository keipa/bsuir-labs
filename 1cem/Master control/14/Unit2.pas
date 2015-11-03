unit Unit2;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;
   type
    amas = array[0..0] of Integer;
    bmas = array[0..0] of Integer;
    cmas = array[0..0] of Integer;
    am = ^amas;
    bm = ^bmas;
    cm = ^cmas;
  procedure   plusort(a,b:Integer;str:TStringGrid);

implementation
   procedure plusort;
    var i,j,r:Integer;
     a1:am;
b1:bm;
c:cm;
   begin



     for i:=1 to a do begin
     c[i]:=a1[i];
     c[a-i]:=b1[i];
     end;



   for i:=1 to a+b do
    for j:=1 to a+b do
      if c[i]> c[j]then
      begin
      r:=c[i];                                       //sorting
      c[i]:=c[j];
      c[j]:=r;
    end;

     for i:=1 to a+b do begin
           str.Cells[i,1]:=IntToStr(c[i]);
      end;

   end;
end.
 