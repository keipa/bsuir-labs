x1 = -1.0; x2 = +1.0; y1 = -1.0; y2 = +1.0;
nx = 30; ny =30 ;

step_x = (x2-x1)/(nx-1); step_y = (y2-y1)/(ny-1);
step_min = min(step_x,step_y);
[x,y] = meshgrid([x1:step_x:x2], [y1:step_y:y2]);
z = 1 ./ sqrt(y.^2 + x.^2);
surf(x,y,z)

xx = reshape(x,1,nx*ny);
yy = reshape(y,1,nx*ny);
zz = 1 ./ sqrt(yy.^2 + xx.^2);
p = [xx; yy];
t = zz;
goal = 0.05;
spread = 1.0*step_min;
net = newrb(p,t, goal,spread);
net.layers{1}.size
b = sim(net,p);
[zz' b']
c = reshape(b,ny,nx);
surf(x,y,c)