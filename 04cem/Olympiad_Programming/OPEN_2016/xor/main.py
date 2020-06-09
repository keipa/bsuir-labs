def hmo(num):
    return str(bin(num)).count('1')


# n = int(input())
# a = []
# xorsum = 0
# for _ in range(n):
#     enter = input().split()
#     # a.append([int(enter[0]), int(enter[1])])
#     xorsum += hmo(int(enter[0]) ^ int(enter[1]))
#     # print()
# print(xorsum)

print(hmo(8 ^ 10))
print(8 ^ 10)
