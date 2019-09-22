# 3.	Написать программу для удаления элементов списка В из списка А. Например, если А=[1,2,4,5], B=[3,4,5], то А-В=[1,2].


astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

bstr = input("input b (ex. 3,4,5)\n").split(",")
b = []
for i in bstr:
    b.append(int(i))


print(set(a)-set(b))