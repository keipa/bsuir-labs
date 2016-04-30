%Для 2PI периодической функции получить разложение в ряд Фурье
%Построить графики функций s0(x), s1(x), s2(x) и s(x) в одной СК
%лабораторная работа 2
% задача 2 вариант 20
%Автор: Ровдо Н.Р.
%БГУИР ФКСИС ИИТП 453504 2015


syms x f1 f2 U a0 an bn;
n = sym ('n', 'integer');
f1 = 4 - 2*x;
f2 = 4 + 2*x;
a0 = simplify(1/2*(simplify(int(f1,x,0,2))+simplify(int(f2,x,-2,0))));
disp(a0);
an = simplify(1/2*(simplify(int(f1*cos(n*x),x,0,2))+simplify(int(f2*cos(n*x),x,-2,0))));
disp(an);
bn = simplify(1/2*(simplify(int(f1*sin(n*x),x,0,2))+simplify(int(f2*sin(n*x),x,-2,0))));
disp(bn);
mas = [0;1;2;1000];
hold on
for i = 1:1:4
  U = a0/2+symsum((an*cos(n*x)+bn*sin(n*x)),n,1,mas(i));
  ezplot(U,[-2,2]);
end
