unit Unit2;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids;

Type  TInf=record
        aj:extended;
        j:word;
      end;
      TSel=^Sel;
      Sel=record
        inf:TInf;
        A:TSel;
      end;

      TLists=class(TObject)
        sp1,sp:TSel;
        procedure Adds(inf:TInf);
        procedure Addsj(inf:TInf);
        function Readsj(j:word):extended;
        procedure Dels;
      end;

      TMsLists=array [1..1] of TLists;

      TMas=array [1..1] of extended;
      PMas=^TMas;

      TListMs=class(TLists)
        ms:^TMsLists;
        m,n:word;
        constructor Create(m0,n0:word);
        destructor Free;
        procedure Add(i,j:word; a:extended);
        procedure Addj(i,j:word; a:extended);
        function Read(i,j:word):extended;
        procedure TrVid;
        procedure Proverka(i1:integer);
      end;

implementation

procedure TListMs.Proverka;
var fi,f:integer;
    si,sd:TSel;
begin
  if ms[i1].readsj(i1)=0 then
    begin
      fi:=i1+1;
      f:=N+1;
      if fi<N then
        Repeat
          if ms[fi].readsj(i1)=0 then
            Inc(fi)
          else
            begin
              f:=fi;
              fi:=N+1;
            end;
        Until fi=N+1;
      if f=fi then
        ShowMessage('Такая матрица не подходит для приведения к треугольному виду')
      else
        begin
          si:=ms[i1].sp1;
          sd:=ms[f].sp1;
          while (si<>Nil) and (sd<>Nil) do
            begin
              si.inf.aj:=si.inf.aj-sd.inf.aj;
              si:=si^.A;
              sd:=sd^.A
            end;
        end;
    end;
end;

procedure TListMs.TrVid;
var fi,fj,fd,fii:integer;
    a1,ai:extended;
    si,sd:TSel;
begin
  fii:=2;
  fj:=1;
  fd:=1;
  Repeat
    fi:=fii;
    Repeat
      Proverka(fd);
      a1:=ms[fi].readsj(fj);
      ai:=ms[fd].readsj(fj);
      si:=ms[fi].sp1;
      sd:=ms[fd].sp1;
      while (si<>Nil) and (sd<>Nil) do
        begin
          si.inf.aj:=si.inf.aj-sd.inf.aj*a1/ai;
          si:=si^.A;
          sd:=sd^.A;
        end;
      Inc(fi);
    Until fi=N+1;
    Inc(fd);
    Inc(fii);
    Inc(fj);
  Until fj=N;
end;

function TLists.Readsj;
begin
	sp:=sp1;
  while (sp<>Nil) and (sp^.inf.j<>j) do
    sp:=sp.A;
	if sp=Nil then
    Result:=0
  else
    Result:=sp^.Inf.aj;
end;

procedure TLists.Adds;
begin
  New(sp);
  sp^.Inf:=Inf;
  sp^.A:=sp1;
  sp1:=sp;
end;

procedure TLists.Addsj;
var spt:TSel;
begin
  New(sp);
  sp^.inf:=inf;
  if sp1=Nil then
    begin
      sp1:=sp;
      sp1^.A:=Nil;
    end
  else
    if sp1^.inf.j>=inf.j then
      begin
        sp^.A:=sp1;
        sp1:=sp;
      end
    else
      begin
        spt:=sp1;
        while (spt^.A<>Nil) and (spt^.A^.inf.j<inf.j) do
          spt:=spt^.A;
          sp^.A:=spt^.A;
          spt^.A:=sp;
        end;
end;

procedure TLists.Dels;
begin
  sp:=sp1;
  sp1:=sp1^.A;
  Dispose(sp);
end;

constructor TListMs.Create;
var i:word;
begin
  m:=m0;
  n:=n0;
  Inherited Create;
  GetMem(ms,4*m);
  for i:=1 to m do
    begin
      ms[i]:=TLists.Create;
      ms[i].sp1:=Nil
    end;
end;

destructor TListMs.Free;
var i:word;
begin
  for i:=1 to m do
  while ms[i].sp1<>Nil do
    ms[i].Dels;
  FreeMem(ms,4*m);
end;

procedure TListMs.Add;
var inf:TInf;
begin
  inf.aj:=a;
  inf.j:=j;
  ms[i].Adds(inf);
end;

procedure TListMs.Addj;
var inf:Tinf;
begin
    inf.aj:=a;
    inf.j:=j;
    ms[i].Addsj(inf);
end;

function TListMs.Read;
begin
  Result:=ms[i].readsj(j);
end;

end.
