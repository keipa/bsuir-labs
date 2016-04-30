unit UStack;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
 TInf = integer;
 Sel = ^TSel;
 TSel = record
  Inf: TInf;
  A: Sel;
  
 end;
 TLists = class
  sp: Sel;
  constructor Create;
  procedure Adds(Inf: TInf);
  procedure Reads(var Inf: TInf);
  procedure AddAfter(spa: Sel; Inf: TInf);
  procedure ReadAfter(spa: Sel; var Inf: TInf);
  procedure Print(ListBox: TListBox);
  function GetSel(index: integer): Sel;
  function Poisk(Inf: TInf): integer;
  function PoiskAfter(spa: Sel; Inf: TInf): integer;
  procedure SortBublInf();
  procedure SortBublAfter(spa: Sel);
 end;
 TZad = class (TLists)
 constructor Create;
 function Task: integer;
 end;
implementation

constructor TLists.Create;
begin
 inherited Create;
 sp:=nil;
end;

constructor TZad.Create;
begin
 inherited Create;
 sp:=nil;
end;
procedure TLists.Adds(Inf: TInf);
var tmp: Sel;
begin
 New(tmp);
 tmp.Inf:= Inf;
 tmp^.A:= sp;
 sp:= tmp;
end;

procedure TLists.Reads(var Inf: TInf);
var tmp: Sel;
begin
 if sp <> Nil then
  begin
   Inf:= sp^.Inf;
   tmp:= sp;
   sp:= sp^.A;
   Dispose(tmp);
  end
 else
  Inf:= 0;
end;

procedure TLists.AddAfter(spa: Sel; Inf: TInf);
var tmp: Sel;
begin
 New(tmp);
 tmp^.Inf:= Inf;
 tmp^.A:= spa^.A;
 spa^.A:= tmp;
end;

procedure TLists.ReadAfter(spa: Sel; var Inf: TInf);
var tmp: Sel;
begin
 if spa^.A <> Nil then
  begin
   Inf:= tmp^.Inf;
   tmp:= spa^.A;
   spa^.A:= tmp^.A;
   Dispose(tmp);
  end
 else
  Inf:= 0;
end;

procedure TLists.Print(ListBox: TListBox);
var tmp: Sel;
begin
 ListBox.Clear;
 tmp:= sp;
 while tmp <> Nil do
  begin
   ListBox.Items.Add(IntToStr(tmp^.Inf));
   tmp:= tmp^.A
  end;
end;

function TLists.GetSel(index: integer): Sel;
var tmp: Sel;
begin
 Result:= Nil;
 tmp:= sp;
 while tmp <> Nil do
  begin
   if index = 0 then
    begin
     Result:= tmp;
     break;
    end;
   Dec(index);
   tmp:= tmp^.A;
  end;
end;

function TLists.Poisk(Inf: TInf): integer;
var tmp: Sel;
    index: integer;
begin
 Result:= -1;
 if sp <> Nil then
  begin
   index:= 0;
   tmp:= sp;
   while tmp <> Nil do
    begin
     if tmp^.Inf = Inf then
      begin
       Result:= index;
       break;
      end;
     Inc(index);
     tmp:= tmp^.A;
    end;
  end;
end;

function TLists.PoiskAfter(spa: Sel; Inf: TInf): integer;
var tmp: Sel;
    index: integer;
begin
 Result:= -1;
 if sp <> Nil then
  begin
   index:= 0;
   tmp:= sp;
   while (tmp <> Nil) and (spa <> tmp) do
    begin
     tmp:= tmp^.A;
     Inc(index);
    end;
   if tmp <> Nil then
    begin
     tmp:= spa^.A;
     Inc(index);
     while tmp <> Nil do
      begin
       if tmp^.Inf = Inf then
        begin
         Result:= index;
         break;
        end;
       Inc(index);
       tmp:= tmp^.A;
      end;
    end;
  end;
end;

procedure TLists.SortBublInf();
var tmp,tmp2: Sel;
    R: TInf;
begin
 if (sp <> Nil) and (sp^.A <> Nil) then
  begin
   tmp:= sp;
   while tmp^.A <> Nil do
    begin
     tmp2:= tmp^.A;
     while tmp2 <> Nil do
      begin
       if tmp2^.Inf < tmp^.Inf then
       begin
         R:= tmp^.Inf;
         tmp^.Inf:= tmp2^.Inf;
         tmp2^.Inf:= R;
       end;
       tmp2:=tmp2^.A;
      end;
      tmp:=tmp^.A;
    end;
  end;
end;

procedure TLists.SortBublAfter(spa: Sel);
var tmp,tmp2: Sel;
    R: TInf;
begin
   if (spa <> Nil) and (spa^.A <> Nil) then
    begin
     tmp:= spa^.A;
     while tmp^.A <> Nil do
      begin
       tmp2:= tmp^.A;
       while tmp2 <> Nil do
        begin
         if tmp2^.Inf < tmp^.Inf then
         begin
           R:= tmp^.Inf;
           tmp^.Inf:= tmp2^.Inf;
           tmp2^.Inf:= R;
         end;
         tmp2:=tmp2^.A;
        end;
        tmp:=tmp^.A;
      end;
    end;
end;

function TZad.Task: integer;
var index,ofs,kfs: integer;
    inf: TInf;
    tmp:Sel;
begin
 while sp <> Nil do
  Reads(index);
 for index:= 1 to 15 do
  Adds(Random(100));
 ofs:= 0;
  kfs:= 0;

 Inf:= sp.Inf;
 index:= 0;
 tmp:= sp;

 while tmp <> Nil do
  begin
   if tmp^.Inf > inf then
    begin
     ofs:= index;
     Inf:=tmp^.Inf;
    end;
   Inc(index);
   tmp:= tmp^.A;
  end;
        Inf:= sp.Inf;
 index:= 0;
 tmp:= sp;
 while tmp <> Nil do
  begin
   if tmp^.Inf < inf then
    begin
     kfs:= index;
     Inf:=tmp^.Inf;
    end;
   Inc(index);
   tmp:= tmp^.A;
  end;
 Result:= Abs(ofs-kfs)-1;
end;
end.
