syms x C1 C2 y1 y2
hold on
grid on
[y1,y2] = dsolve('Dy1 = 3*y1+12*y2,Dy2 = y1+7*y2','y1(0)= 0','y2(0)=1','x')
p = ezplot(y1,y2,[-2 2])
