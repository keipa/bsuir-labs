unit FileFunc;

interface
 uses
  Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls;

 procedure Pclear(E1,E2,E3,E4:TEdit;M1,M2:TMemo);
implementation

 procedure Pclear(E1,E2,E3,E4:TEdit;M1,M2:TMemo);
  begin
    E1.Clear;
    E2.Clear;
    E3.Clear;
    E4.Clear;
    M1.Clear;
    M2.Clear;
  end;
end.
