syms x FpK Ckoeff
hold on
grid on
for FpK= -10:2:10
    y = x*x+FpK;

    plot_izoklin = ezplot(y);
     axis([-10,10,-10,50])
     set(plot_izoklin,'Color','red')
end


for Ckoeff = -30:5:0
y=(2*x+Ckoeff*exp(x)+x*x+2);
plot_integ = ezplot(y)
set(plot_integ,'Color','blue')
axis([-10,10,-20,40])
end;
plot_particular = ezplot(dsolve('Dy = (y-x*x )','y(-3)=4','x'))
set(plot_particular,'Color','Black')
axis([-10,10,-20,40])
disp('Общее решение')
pretty(dsolve('Dy = (y-x*x )','x'))
disp('Частное решение')
pretty(dsolve('Dy = (y-x*x )','y(-3)=4','x'))