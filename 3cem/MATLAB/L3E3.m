disp('Общее решение')
pretty(dsolve('4*Dy+x^3*y=(x^3+8)*exp(-2*x)*y^2','x'))
disp('Частное решение')
pretty(dsolve('4*Dy+x^3*y=(x^3+8)*exp(-2*x)*y^2','y(0)=1','x'))
