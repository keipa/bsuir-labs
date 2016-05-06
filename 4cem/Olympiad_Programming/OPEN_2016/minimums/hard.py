n = int(input())
a = input().split()
print(a[1:2])
for i in range(len(a)):
    a[i] = int(a[i])
print(a)
n = 0
# for i in range(len(a)):
#     while i+n<=