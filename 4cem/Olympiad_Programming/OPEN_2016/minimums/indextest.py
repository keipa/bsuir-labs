n = "3 4 6 7 3 5 7".split()

offset = 0
for i in range(0, len(n), 1):
    while i + offset < len(n):
        j = i + offset
        print(i, " ", j)
        offset += 1
    print()
    offset = 0

