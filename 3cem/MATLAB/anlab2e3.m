syms x f1 f2 U a0 an bn;
n = sym('n', 'integer');
f1 = 3*x;
f2 = -3*x+6;
a0 = simplify(simplify(int(f1,x,0,1))+simplify(int(f2,x,1,2)));
disp('a0 =');
disp(a0);
an = simplify(simplify(int(f1*cos(n*x*pi/2),x,0,1))+ simplify(int(f2*cos(n*x*pi/2),x,1,2)));
disp('an = ');
disp(an);
bn = simplify(simplify(int(f1*sin(n*x*pi/2),x,0,1)) + simplify(int(f2*sin(n*x*pi/2),x,1,2)));
disp('bn = ');
disp(bn);
mas  = [3;1000];
hold on
for i = 1:1:2
    U = a0/2+symsum(an*cos(n*x*pi/3),n,1,mas(i));
    ezplot(U,[-2,2]);
end
for i = 1:1:2
    U  = symsum(bn*sin(n*x*pi/3),n,1,mas(i));
    ezplot(U, [-2,2])
end
