import  math
from random import random
b = 0
d = 0
float(d)

print(b)
a = int( input("input a: "))
b = int( input("input b: "))
c = int( input("input c: "))
print("you entered ("+str(a)+")x^2+("+str(b)+")x+"+str(c))
d = b*b-4*a*c
print("desc ",d)
if d < 0:
    print("there's no squares")

if d == 0:
    print(-b/(2*a))
if d > 0:
    print("x1 =",(-b+math.sqrt(d))/(2*a))
    print("x2 =",(-b-math.sqrt(d))/(2*a))


