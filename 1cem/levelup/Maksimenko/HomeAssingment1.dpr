program HomeAssingment1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  a,b:integer;

function GCD(M,N:integer):integer;
begin
  while (M <> 0) and (N <> 0) do
    if M>N then
       M:=M-N
    else N:=N-M;
   result:=N+M;
end;

function LCM(M,N:integer):integer;
begin                           // число result получится целым
  result:=round(M*N/GCD(M,N));  // результат со знаком делить "/" в Delphi имеет вещественный тип
end;                            // round нужен для того чтобы программа не бросала exception

//через строки
procedure PolyndromS(n,m:integer);
var
  p,i,num:integer;
  k,s:string;
begin
  for num:=n to m do
  begin
    k:='';
    p:=num;
    s:=inttostr(p);
    for i:=length(s) downto 1 do k:=k+s[i];
    if strtoint(k) = p then writeln(p);
  end;
end;

//математически
procedure PolyndromM(n,m:integer);
var
  i,num,a,b,p:integer;
begin
  for num:=n to m do
  begin
    p:=num;
    a:=0;
    while(p<>0) do
    begin
      b:=p mod 10;
      a:=a*10 + b;
      p:=p div 10;
    end;
    if a = num then writeln(num);
  end;
end;



begin
  writeln('Enter two numbers for LCM and GCD finding: ');
  readln(a, b);
  writeln('GCD = ', GCD(a,b));
  writeln('LCM = ', LCM(a,b));
  writeln('Enter the distance of a polyndrom search(Ex.: 100 7000): ');
  readln(a,b);
  writeln('Via strings:');
  PolyndromS(a,b);
  writeln('Via pure maths:');
  PolyndromM(a,b);

  //А как насчёт рекурсивного нахождения полиндрома? кто осилит? =)
  //PolyndromR(a,b);

  readln;
end.
