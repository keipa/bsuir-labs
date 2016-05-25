

m = 8
N = 22
B = "cocacolacoclca"
s = "coca"
Prefix = [0, 4, 6, 8, 7, 4]


i, j, k = 1
while N-k > m:
    while j <= m and B[i] == s[j]:
        i += 1
        j += 1
    if j > m:           print(k)
    if Prefix[j-1] > 0: k = i - Prefix[j-1]
    elif i == k:        i += 1
    k = i
    if j > 1:           j = Prefix[j-1] + 1