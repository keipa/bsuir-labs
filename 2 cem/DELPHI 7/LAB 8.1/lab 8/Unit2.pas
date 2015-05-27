Unit Unit2;
interface
uses SysUtils;
	Type
   Tkey = LongWord;
   Tinf = Record
       S   : string[80];
       key : Tkey;
         end;
   TMs=array[1..10] of TInf;
 Ptree = ^tree;
 Tree = Record
      Inf:TInf;
      A1:Ptree;
      A2:Ptree;
        end;
 Ttree=Class(TObject)
Constructor create;
Procedure AddB(Inf:TInf);
Procedure Make1B(a:Tms; n:word);
Procedure Wrt2;
		Procedure View;
		Procedure WrtB;
		Destructor Free;
     Procedure BLns(a:Tms; n:word);
     Function poisk(k:Tkey):Tinf;
     Procedure Delk(k:Tkey);
      procedure Delete(p:Ptree);
		    End;
        type
  Tbtr=Class(Ttree)
      procedure  simvol;
  end;
  var  	proot,p,q,v,w : Ptree;
  Const nok:Tkey=120;
Implementation
 uses unit1;

Constructor Ttree.create;
	Begin
	 Inherited create; proot:=nil;
	End;

  procedure Ttree.Delete(p:Ptree);
begin
  if p=nil then Exit;
  Delete(p^.A1);
  Delete(p^.A2);
  Dispose(p);
  proot:=Nil;
end;

Procedure Ttree.AddB(Inf:TInf);
 Var bl:Boolean;
 begin
     	New(w);
		w^.Inf:=Inf;
		w^.A1:=Nil;
w^.A2:=Nil;
			if proot=Nil then proot:=w
	      					   else begin
                p:=proot;
	   repeat
     q:=p;
		    bl:=Inf.key<p^.Inf.key;
if bl then p:=p^.A1
 else p:=p^.A2;
   until p=Nil;
	            if bl then q^.A1:=w
                    else q^.A2:=w;
		                        end;
end;

Procedure Ttree.Make1B(a:Tms; n:word);
 var i:integer;
	  begin
		For i:=1 to n do AddB(a[i]);
	end;

Procedure Ttree.View;
   var kl : integer;
 Procedure VW(p:ptree;Var kl:Integer);
   Begin
    if  p <> Nil then
        with Form1.TreeView1.Items do begin
    if kl=-1 then AddFirst(Nil, p^.Inf.s+' '+IntToStr(p^.Inf.key))
else AddChildFirst(Form1.TreeView1.Items[kl],p^.Inf.s+' '+IntToStr(p^.Inf.key));
      Inc(kl); VW(p^.A1,kl); VW(p^.A2,kl); Dec(kl);
      end;
      end;
begin 
  Form1.TreeView1.Items.Clear;
  p:=proot;  kl:=-1;  VW(p,kl);
  Form1.TreeView1.FullExpand;
end;

Destructor Ttree.Free;
 Procedure Delett(p:Ptree); 
  Begin 
   If p=nil then Exit;
      Delett(p^.A1);
      Delett(p^.A2);
         Dispose(p);
         p:=Nil;
  end;
 begin
   Delett(proot);
  Inherited  Destroy;
 end;

Procedure Ttree.WrtB;
 Procedure Wr(p:Ptree);
	   begin
		if p<>nil then
		  begin
Form1.Memo1.Lines.Add(p^.Inf.s+'  '+IntToStr(p^.Inf.key));
			Wr(p^.A1);
			Wr(p^.A2);
		  end;
  end;
	begin
 p:=proot;
  wr(p)
end;

procedure Ttree.BLns;
	    procedure BL(i,j:word);
	    var m:word;
	    begin
		    if i<=j then
		      begin
			      m:=(i+j) div 2;
			      AddB(a[m]);
			      BL(i,m-1);
			      BL(m+1,j);
		      end;
	    end;
begin
  proot:=Nil;
  BL(1,n);
end;

 Function Ttree.poisk;
  begin p:=Proot;
	While(p<>nil) and (p^.Inf.key<>k) do
	  If k<p^.Inf.key then p:=p^.A1
				   else p:=p^.A2;
  if p<>Nil then Result:=p^.inf
		    else Result.key:=nok;
  end;

procedure Ttree.Delk;
begin
  p:=proot;
  while (p<>Nil) and (p^.Inf.key<>k) do
		begin
      q:=p;
        if p^.Inf.key>k then
          p:=p^.A1
        else
          p:=p^.A2;
		end;
	if p<>Nil then
    begin
	    if p=proot then
        begin
          New(q);
          q^.A1:=p;
        end;
	    if (p^.A1=Nil) and (p^.A2=Nil) then
	      if q^.A1=P then
          q^.A1:=Nil
			  else
          q^.A2:=Nil
	    else
	      if P^.A1=Nil then
	        if q^.A1=P then
            q^.A1:=p^.A2
				  else
            q^.A2:=p^.A2
	      else
          if p^.A2=Nil then
	          if q^.A1=P then
              q^.A1:=p^.A1
				    else
              q^.A2:=p^.A1
	        else
		        begin
		          w:=p^.A1;
              if w^.A2=Nil then
                w^.A2:=p^.A2
		          else
                begin
			            Repeat
                    v:=w;
                    w:=w^.A2;
			            Until w^.A2=Nil;
			            v^.A2:=w^.A1;
			            w^.A1:=p^.A1;
			            w^.A2:=p^.A2;
			          end;
		          if q^.A1=P then
                q^.A1:=w
					    else
                q^.A2:=w;
		        end;
	    if p=proot then
        begin
          proot:=q^.A1;
          Dispose(q);
        end;
	    Dispose(p);
    end;
end;

Procedure Ttree.Wrt2;
	  Procedure Wr(p:Ptree);
	   begin
		if p<>nil then
		  begin
			Wr(p^.A2);
      Form1.Memo1.Lines.Add(p^.Inf.s+'  '+IntToStr(p^.Inf.key));
			Wr(p^.A1);
		  end;
	  end;
begin
     p:=proot; wr(p)
end;

procedure Tbtr.simvol;
       Procedure Wr(p:Ptree);
	   begin
		if p<>nil then
		  begin
Form1.Memo1.Lines.Add(p^.Inf.s+'  '+IntToStr(length(p^.Inf.s)));
			Wr(p^.A1);
			Wr(p^.A2);
		  end;
  end;
	begin
 p:=proot;
  wr(p)
	    end;
end.

