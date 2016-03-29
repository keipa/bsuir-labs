def matrix_out(a):
    for n in a:
        for m in n:
            print(m, end="")
        print()

alphabet = "a b c d e f g h i j k l m n o p q r s t u v w x y z".split()
inpt = input().split()
n, m = int(inpt[0]), int(inpt[1])
a = [[0] * m for i in range(n)]
#solve the task

letter_number = 0
# print(len(alphabet))

if n % 2 == 0 and m % 2 == 0:
    for stroke in range(0, n, 2):
        for stolb in range(0, m, 2):
            a[stroke][stolb] = alphabet[letter_number]
            a[stroke+1][stolb] = alphabet[letter_number]
            a[stroke][stolb+1] = alphabet[letter_number]
            a[stroke+1][stolb+1] = alphabet[letter_number]
            letter_number += 1
if n % 2 != 0 and m % 2 ==0:
    for stik in range(0, m, 4):
        a[0][stik] = alphabet[letter_number]
        a[0][stik+1] = alphabet[letter_number]
        a[0][stik+2] = alphabet[letter_number]
        a[0][stik+3] = alphabet[letter_number]
        letter_number += 1
    for stroke in range(1, n, 2):
        for stolb in range(0, m, 2):
            a[stroke][stolb] = alphabet[letter_number]
            a[stroke+1][stolb] = alphabet[letter_number]
            a[stroke][stolb+1] = alphabet[letter_number]
            a[stroke+1][stolb+1] = alphabet[letter_number]
            letter_number += 1
if m % 2 != 0 and n % 2 ==0:
    for stik in range(0, n, 4):
        a[stik][0] = alphabet[letter_number]
        a[stik+1][0] = alphabet[letter_number]
        a[stik+2][0] = alphabet[letter_number]
        a[stik+3][0] = alphabet[letter_number]
        letter_number += 1
    for stroke in range(0, n, 2):
        for stolb in range(1, m, 2):
            a[stroke][stolb] = alphabet[letter_number]
            a[stroke+1][stolb] = alphabet[letter_number]
            a[stroke][stolb+1] = alphabet[letter_number]
            a[stroke+1][stolb+1] = alphabet[letter_number]
            letter_number += 1

matrix_out(a)

