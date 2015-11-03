unit Unit2;

interface
  uses StdCtrls, SysUtils;
  function FComp(St:string;Stk:string):string;
  function FDiff(Slovo,St1,Stk1:string):word;
implementation
  function FComp(St,Stk:string):string;
    var
      k,i,wrd,spc,n:integer;
      slv:string;
    begin
      k:=StrToInt(Stk);
      if St[k]=' ' then k:=k-1;
      wrd:=1;
      spc:=0;
      for i:=1 to k do
        if St[i]=' ' then
          begin
           Inc(wrd);   //Кол-во слов;
           spc:=i;     //Позиция пробела перед нужным словом;
          end;
      i:=0;
      Inc(spc);
      n:=spc;
      while St[n]<>' ' do
        begin
          Inc(i);
          Inc(n);
        end;
      slv:=Copy(St,spc,i);
      Result:='Por. nomer: '+IntToStr(wrd)+' Kol-vo odinak. simvolov: '+IntToStr(FDiff(slv,St,Stk));
    end;

   function FDiff(Slovo,St1,Stk1:string):word;
    var
      a,b: set of char;
      i,m: integer;
    begin
      m:=0;
      a:=[];
      b:=[];
      for i:=1 to Length(Slovo) do
          if (not(Slovo[i] in a)) and (not(Slovo[i] in b)) then Include(a,Slovo[i])
              else if (Slovo[i] in a) and (not(Slovo[i] in b)) then
                  begin
                    Inc(m);
                    Include(b,Slovo[i]);
                  end;
      Result:=m;
    end;
end.
