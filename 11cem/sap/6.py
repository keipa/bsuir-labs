# 6.	Написать рекурсивную функцию для вычисления минимального элемента списка

def mini(arr):
    if len(arr) == 1:
        return arr[0]
    return min(arr.pop(), mini(arr))

astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

print(mini(a))