# 9.	Написать рекурсивную функцию для подсчета числа инверсий в списке. Инверсия – это ситуация, когда в соседней паре элементов следующий элемент меньше предыдущего.


def inverse_count(a):
    if len(a) == 1:
        return 0
    return int(a.pop(0) > a[0])+inverse_count(a)

astr = input("input a (ex. 1,2,4,5)\n").split(",")
a = []
for i in astr:
    a.append(int(i))

print(inverse_count(a))