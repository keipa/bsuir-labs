x = 1;
for i = 0:.1:1;
for j = 0:.1:1;
D(1,x) = i;
D(2,x) = j;
T(x) = 2*i*i - 2*j*j + 4*i*j - 4*i + 3*j - 3
x = x+1;
end;
end;

