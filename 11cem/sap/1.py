# 1.	Написать код для определения дополнения списка. Например, если B=[1,5,8], то не-B=[2,3,4,6,7,9]. Список  не-В  есть дополнение списка В.

a = set([i for i in range(1,10)])
b = input("input list (ex. 1,4,6) \n").split(",")
c = []
for i in b:
    c.append(int(i))
c = set(c)
print(a-c)