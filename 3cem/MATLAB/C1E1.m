%f = dsolve('D3y-2*D2y-Dy+2*y=0')
%g = dsolve('m*D2y-k*Dy=0','y(0)=0,y(1)=1','x')
%pretty(g)
f=dsolve('4*D2y+0.8*Dy+2*y=20','y(0)=-1, Dy(0)=0','x')
ezplot(f,[0, 70]); axis([0 70 0 20]); grid on;
pretty(f)


