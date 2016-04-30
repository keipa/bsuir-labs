unit Unit2;

interface

uses Math;

type
  TStack = ^Stack;
  Stack = record
    inf: Char;
    a: TStack;
  end;
  CStack = class (TObject)
    procedure Add (var p:TStack; s:char);
    procedure Read (var p:TStack; var s:char);
    function AV (strp: string):Extended;
    function Priority (ch:Char):Byte;
    procedure OBP (var stri, strp: string);
  end;

var
  str: string;
  mszn: array[97..200] of Extended;
  stk: TStack;

implementation

procedure CStack.Add;
var
  Pt: TStack;
begin
  if p = nil then
    begin
      New(p);
      p^.inf:=s;
      p^.a:=nil;
    end
  else begin
         New(pt);
         Pt^.inf:=s;
         Pt^.A:=p;
         P:=Pt;
       end;
end;

procedure CStack.Read;
var
  pt: TStack;
begin
  s:=p^.inf;
  pt:=p;
  p:=p^.a;
  Dispose(pt);
end;

function CStack.AV;
var
  Ch, ch1, ch2, chr: Char;
  op1, op2, rez: Extended;
  i: byte;
begin
  chr:=Succ('z');
  for i:=1 to Length(strp) do
    begin
      ch:=strp[i];
      if not (ch in ['*','/','+','-','^']) then Add(stk,Ch)
      else begin
            read(stk,ch1);
            read(stk,ch2);
            op1:=mszn[Ord(ch1)];
            op2:=mszn[Ord(ch2)];
            case Ch of
              '+': rez:=op2+op1;
              '-': rez:=op2-op1;
              '*': rez:=op2*op1;
              '/': rez:=op2/op1;
              '^': rez:=Power(op1,op2);
            end;
            mszn[ord(chr)]:=rez;
            Add(stk,chr);
            Inc(chr);
           end;
    end;
  Result:=rez;
end;

function CStack.Priority;
begin
  case ch of
    '(',')': Result:=0;
    '+','-': Result:=1;
    '*','/': Result:=2;
    '^'    : Result:=3;
  end;
end;

procedure CStack.OBP;
var
  stk: TStack;
  pc: 0..3;
  n,i: Byte;
  Ch, ch1: char;
  bl: Boolean;
begin
  strp:='';
  n:=Length(stri);
  stk:=nil;
  for i:=1 to n do
    begin
      ch:=stri[i];
      if ch in ['+','-','*','/','(',')','^'] then
        if ch = '(' then Add(stk,Ch)
          else if Ch = ')' then
                 begin
                  read(stk,Ch);
                  while Ch<>'(' do
                    begin
                      strp:=strp+ch;
                      read(stk,Ch);
                    end;
                  end
                else  if stk = nil then Add(stk,Ch)
                      else begin
                              pc:=priority(Ch);
                              repeat
                                  read(stk,ch1);
                                  bl:=Priority(ch1)>=pc;
                                  if bl then strp:=strp+ch1
                                    else add(stk,ch1);
                              until (stk = Nil) or (not bl);
                              Add(stk,Ch);
                           end
       else strp:=strp+ch;
    end;
  while stk<>nil do
    begin
      read(stk,Ch);
      strp:=strp+ch;
    end;
end;

end.
