[X,Y] = meshgrid(-1:0.1:1);
quiver(X,Y,Y,X); % строим поле направлений (вектор [Y,X] в точке [X,Y])
hold on;
[x y]=dsolve('Dx = y, Dy = x','x(0)=0,y(0)=0.5');
ezplot(x,y,[-1.35 1.35]);
[x y]=dsolve('Dx = y, Dy = x','x(0)=0.5,y(0)=0');
ezplot(x,y,[-1.35 1.35]);
[x y]=dsolve('Dx = y, Dy = x','x(0)=-0.5,y(0)=0');
ezplot(x,y,[-1.35 1.35]);
[x y]=dsolve('Dx = y, Dy = x','x(0)=0,y(0)=-0.5');
ezplot(x,y,[-1.35 1.35]);
hold off;