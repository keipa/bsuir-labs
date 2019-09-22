# 8.	Написать рекурсивную функцию для вычисления результата объединения двух списков

def myunion(a,b):
    if len(a) == 0:
        return b
    if len(b) == 0:
        return a
    s = [a.pop(),b.pop()]
    nex = myunion(a,b)
    return s+nex


astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

bstr = input("input b (ex. 3,4,5)\n").split(",")
b = []
for i in bstr:
    b.append(int(i))

print(myunion(a,b))