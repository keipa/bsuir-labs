# 4.	Написать программу для вычисления пересечения двух списков. Например, А=[1,2,4,5], B=[3,4,5], то А В=[4,5].


astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

bstr = input("input b (ex. 3,4,5)\n").split(",")
b = []
for i in bstr:
    b.append(int(i))

print(set(a).intersection(set(b)))