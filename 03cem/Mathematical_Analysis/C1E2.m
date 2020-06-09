sys='Dx = y-z, Dy = z-x, Dz=x-2*y';
cnd='x(0)=1,y(0)=0, z(0)=2';
[x,y,z]=dsolve(sys,cnd);
pretty([x,y,z]);
ezplot3(x,y,z,[-4 6]);
