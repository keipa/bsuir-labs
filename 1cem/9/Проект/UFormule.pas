unit UFormule;

interface

  uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls;


  function FFirst (a,b,c:extended):extended;
  function FSecond (a,b,c:extended):extended;
  function FThird (a,b:extended):extended;

implementation
  function FFirst;
    begin
      Result:=a+(b-c);
    end;
  function FSecond;
    begin
      Result:=a-(b-c);
    end;
  function FThird;
    begin
      Result:=(a+b)/2;
    end;
end.
