# 5.	Написать рекурсивную функцию для вычисления суммы элементов списка


def sum(arr):
    if len(a) == 0:
        return 0
    return arr.pop()+sum(arr)

astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

print(sum(a))