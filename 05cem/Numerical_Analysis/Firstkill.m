%Методами коллокаций, интегральным и дискретным методами
%наименьших квадратов и Галеркина получить численное решение краевой задачи

clc;% 
clear;% 
syms y n x f1 f2 i fi k toSolve ;   %  
aArray = sym('a%d',[ 1 9]); % 
a = -1;% 
b = 1;% 
fi(n) = x^n * (1 - x);  % 
y =  0 ;% 
n = 10;% 
for i=1:n-1
    y =  y + aArray(i) * fi(i); % присвоение для каждой итерации i значение дял метода коллокаций
end
psi(x) = sin(15) * diff(y,'x',2) + (1 + cos(15)*x*x)* y + 1; %невязка
xEs = (-1 + 2/n):2/n:(1 - 2/n); %точки коллокации
for i=1:length(xEs)
    toSolve(i) = psi(xEs(i)); %подстановка
end
array = solve(toSolve == zeros(1,length(xEs))); %решение

a(1) = double(array.a1);  %установка значений для построения графика
a(2) = double(array.a2); %~_~
a(3) = double(array.a3); %~_~
a(4) = double(array.a4); %~_~
a(5) = double(array.a5); %~_~
a(6) = double(array.a6); %~_~
a(7) = double(array.a7); %~_~
a(8) = double(array.a8); %~_~
a(9) = double(array.a9); %~_~
disp('метод коллокаций'); % вывод на консоль
disp(a); % отображение на консоль значения а
% hold on; %включает режим сохранения текущего графика и свойств объекта axes
ResultY(x) = subs(y,aArray,a);
plot(xEs,ResultY(xEs))
% интегральный метод
a = -1;
b = 1;
for i=1:length(xEs)
    I(i) = 2 * int ( psi(x) * diff(psi(x),aArray(i)),'x',a,b);
    %минимизируем интеграл от квадрата невязки
end
array = solve(I == 0); %строим систему нормальных уравнений
a(1) = double(array.a1); %установка значений для построения графика
a(2) = double(array.a2); %~_~
a(3) = double(array.a3); %~_~
a(4) = double(array.a4); %~_~
a(5) = double(array.a5); %~_~
a(6) = double(array.a6); %~_~
a(7) = double(array.a7); %~_~
a(8) = double(array.a8); %~_~
a(9) = double(array.a9); %~_~
disp('метод интегральный');
disp(a); % отображение на консоль значения а
ResultY(x) = subs(y,aArray,a); % Подстановка в символьных выражениях
plot(xEs,ResultY(xEs), 'red'); % рисование графика
% дискретный мнк
a = -1;
b = 1;
points = 100; %выбираем точки
axis = a:(b-a)/points:b;  % конфигурирование оси
    S(1) = 0;
for i=1:length(axis);
    S = S + psi(axis(i))^2; %находим сумму квадратов невязки
end
for i=1:length(xEs)
    Ds(i) = diff(S,aArray(i)); %находим систему решений
end
array = solve(Ds == 0); %решаем
a(1) = double(array.a1);%установка значений для построения графика
a(2) = double(array.a2); %~_~
a(3) = double(array.a3); %~_~
a(4) = double(array.a4); %~_~
a(5) = double(array.a5); %~_~
a(6) = double(array.a6); %~_~
a(7) = double(array.a7); %~_~
a(8) = double(array.a8); %~_~
a(9) = double(array.a9); %~_~
disp('метод дискретный');
disp(a);% отображение на консоль значения а
ResultY(x) = subs(y,aArray,a);
plot(xEs,ResultY(xEs), 'green');
% галеркина метод
a = -1;
b = 1;
for i=1:length(xEs)
    I(i) = int (psi(x)*fi(i),x,a,b);
    %строим систему уравнений из интегралов от невязки
end

array = solve(I == 0); %решаем
a(1) = double(array.a1);%установка значений для построения графика
a(2) = double(array.a2); %~_~
a(3) = double(array.a3); %~_~
a(4) = double(array.a4); %~_~
a(5) = double(array.a5); %~_~
a(6) = double(array.a6); %~_~
a(7) = double(array.a7); %~_~
a(8) = double(array.a8); %~_~
a(9) = double(array.a9); %~_~
disp('метод Голеркина');
disp(a);% отображение на консоль значения а
ResultY(x) = subs(y,aArray,a);
% plot(xEs,ResultY(xEs), 'yellow');
