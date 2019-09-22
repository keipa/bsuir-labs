# 7.	Написать рекурсивную функцию для вычисления элемента списка, стоящего на данной позиции (нумерация начинается с 0)

def ind(arr,i):
    if len(arr) < i:
        print("index is out of range")
        return

    if i == 0:
        return arr.pop(0)
    arr.pop(0)
    return ind(arr, i-1)

astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

i = int(input("input index\n"))

print(ind(a,i))