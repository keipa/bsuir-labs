clc;% очистка командной строки
clear;% очистка консоли
reset(symengine);% рестарт
syms x y u% инициализация переменных
g = double(1); % присваиваем переменной l
N = 20;% присваиваем переменной n значение 20
v = double(rand(N+1)); % квадрат
eps = 0.01;% присваиваем переменной eps значение 0,01
dmax = 1;% присваиваем переменной dmax значение 1
f(x, y) = x^2 + y^2; % заданная достаточно гладкая функция
h = 1/N;% присваиваем переменной h значение 1/20
for i = 1:N+1 % фиксируем края
    v(i,1) = g;
    v(i, N+1) = g;
    v(1, i) = g;
    v(N+1, i) = g;
end

for i = 2:N
    for j = 2:N
        fij(i, j) = double(f((i-1)*h,(j-1)*h)); %заполняем функцию
    end
end

while(dmax > eps)
    dmax = 0;
    for i=2:N
        for j=2:N
            temp = v(i,j);
            v(i,j) = double(0.25*(v(i-1,j)+v(i+1,j)+v(i, j-1)+v(i,j+1)- fij(i, j)));
            %находим значение в каждой точке сетки из разностного ур-ия
            dm = abs(temp - v(i, j)); % разница после разностного уравнения
            if dmax < dm
                dmax = dm;
            end
        end
    end
    disp( dmax);
end
[X,Y] = ndgrid(0:h:1, 0:h:1);
disp(v);
surf(X, Y, v)
