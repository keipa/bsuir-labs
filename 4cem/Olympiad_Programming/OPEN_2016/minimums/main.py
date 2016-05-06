import math

def matrix_out(a):
    for n in a:
        for m in n:
            print(m, end="")
        print()

n = int(input())
a = input().split()
# n = 4
# a = "1 3 2 1".split()
st = [[0] * n for i in range(n)]

current_symbol = 0
while current_symbol < n:
    st[0][current_symbol] = int(a[current_symbol])
    current_symbol += 1

for k in range(1, n-1, 1):
    for i in range(0, n-1, 1):
        if i + 2 ** (k - 1) <= n - 1:
            st[k][i] = min(st[k-1][i], st[k-1][i + 2 ** (k-1)])

answer = 0
offset = 0
for i in range(0, len(a), 1):
    while i + offset < len(a):
        j = i + offset
        k = math.log(j - i + 1)
        k = math.floor(k)
        answer += min(st[k][i], st[k][j-2**k+1])
        offset += 1
    offset = 0

print(answer)
