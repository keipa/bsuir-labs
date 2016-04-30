












syms p t Y
f = 2
F = laplace(f,t,p)
Y1 = p*Y - 1
Y2 = p*Y1;
SOL = solve(Y2-Y1-6*Y-F,Y)
sol = ilaplace(SOL,p,t)
