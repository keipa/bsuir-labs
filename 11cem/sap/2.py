# 2.	Написать программу для вычисления A  не-B.
# Здесь    - символ объединения списков. Не-B значит дополнение списка. Например, если B=[1,5,8], то не-B=[2,3,4,6,7,9].
a = set([i for i in range(1,10)])
b = input("input list (ex. 1,4,6) \n").split(",")
c = []
for i in b:
    c.append(int(i))
c = set(c)



print(list(a)+list(a-c))