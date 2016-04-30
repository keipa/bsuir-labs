unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
   ppt = ^node;
   node=record
    inf:integer;
    pred,next:ppt;
    end;
    TLists=class(TObject)


  procedure init(var p:ppt; newint:integer);
  procedure add(p:ppt; newint:integer);
  procedure addafter(p:ppt; newint:Integer);
  procedure bubblesort(var p:ppt);
  procedure shows(p:ppt; lb1:TListBox);
 // procedure showsVAR(p:ppt; lb1:TListBox);

  Procedure Dell(var p:ppt; s:integer);
    Procedure minup(var p:ppt ;  lb1:TListBox);
  end;
var

  p,tmp:ppt; first:ppt;   min: Integer;
implementation

procedure TLists.init(var p:ppt; newint:integer);
begin
  new(p);
  first:=p;
  p^.inf:=newint;
  p^.next:=nil;
  p^.pred:=nil;
  new(tmp);
  tmp^.inf:=newint;
  tmp^.next:=nil;
  tmp^.pred:=nil;
end;


procedure TLists.add(p:ppt; newint:integer);
var q,r:ppt;
begin
  q:=p;
  if q^.next=nil then begin
    new(r);
    r^.inf:=newint;
    r^.next:=q^.next;
    q^.next:=r;
    r^.pred:=q;
  end else add(p^.next,newint);
  end;

procedure TLists.addafter(p:ppt; newint:integer);
var q,r:ppt;
begin
  q:=p;
 // if q^.next=nil then begin
    new(r);
    r^.inf:=newint;
    r^.next:=q^.next;
    q^.next:=r;
    r^.pred:=q;
 // end else addafter(p^.next,newint);
  end;

procedure TLists.shows(p:ppt;lb1:TListBox);
begin
  lb1.Items.Clear;
  while p<>nil do
    begin
    lb1.Items.Add(IntToStr(p^.inf));
    p:=p^.next;
    end;
  end;

{procedure TLists.showsVAR(p:ppt;lb1:TListBox);
var i :integer;
begin

  i := lb1.Items.

   while p<>nil do
    begin
    lb1.Items.Add(IntToStr(p^.inf));
    p:=p^.next;
    end;
end;  }

procedure TLists.bubblesort(var p:ppt);
var b:integer;
pt:ppt;
c:boolean;
begin
               repeat
               pt:=p;
              //a:=first;
              c:=false;
                   while p^.next<>nil do
                   begin
                             if(p^.next<>nil)and(p^.inf>p^.next^.inf)then
                             begin
                             b:=p^.inf;
                             p^.inf:=p^.next^.inf;
                             p^.next^.inf:=b;
                             c:=true;
                             end;
                   p:=p^.next;
                   end;
                   p:=pt;
              until not c;
end;


Procedure TLists.Dell(var p:ppt; s:integer);

Var Pt:ppt;
Begin
Pt:=p;
While p<> nil do Begin
If s=p^.inf then Begin
If p^.pred=nil then Begin
If p^.next<>nil then begin

p^.next^.pred:=nil;
p:=p^.next;
end else p:=nil;
dispose(pt);
s:=-1;
End else If p^.next=nil then Begin
P^.pred^.next:=nil;

Dispose(P);
P:=pt;
S:=-1;
End else Begin
p^.pred^.next:=p^.next;

p^.next^.pred:=p^.pred;

dispose(p);
s:=-1;
p:=pt;
end;
End;

If s=-1 then exit;
P:=p^.next;
End;
End;

procedure Tlists.minup(var p:ppt ;  lb1:TListBox);
var first:ppt; src:ppt;
begin
  first:=p;
  min:=p.inf;
  while (p.next <> nil) do
  begin
    if  p.inf < min then min:=p.inf;
    p:=p.next;
  end;
  lb1.Clear;
  lb1.Items.Add(IntToStr(min));
     p:=first;
  while (p <> nil) do
  begin
    if  p.inf <> min then lb1.Items.Add(IntToStr(p.inf));
    p:=p.next;
  end;
end;


end.
