syms s sn n k
sn = symsum((-1)^n/n,1,inf)
s = limit((-1)^k/k,k,inf)
disp(sn)
disp(s)