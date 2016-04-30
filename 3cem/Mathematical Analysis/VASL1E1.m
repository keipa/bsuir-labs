

syms x n
w = warning ('off','all');
series_n = ((1-x)/(1+x))^n/(2*n-1)
series_nplus = ((1-x)/(1+x))^(n+1)/(2*(n+1)-1)
series_kosh = (((1-x)/(1+x))^n/(2*n-1))^(1/n)

limit(series_kosh,n,inf)