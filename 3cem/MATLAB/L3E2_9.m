grid on
syms x x0 y0 f
hold on
x0 = 3
y0 = -1
y = -(x/3)^(3/2)
p = ezplot(y)
f = diff(y)
y= subs(f,x0)*(x-x0)+y0
p = ezplot(y)
axis([0,6,-3,1])
