def matrix_out(a):
    for n in a:
        for m in n:
            print(m, end="")
        print()


def tetra(n,m):
    print(n, " ", m)
    alphabet = "a b c d e f g h i j k l m n o p q r s t u v w x y z".split()
    a = [[0] * m for i in range(n)]
    #solve the task

    letter_number = 0

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


tetra(1,4)
tetra(1,8)
tetra(3,4)
tetra(3,8)
tetra(5,4)
tetra(5,8)
tetra(7,4)
tetra(7,8)
tetra(9,4)
tetra(9,8)
tetra(2,2)
tetra(2,4)
tetra(2,6)
tetra(2,8)
tetra(2,10)
tetra(4,2)
tetra(4,4)
tetra(4,6)
tetra(4,8)
tetra(4,10)
tetra(6,2)
tetra(6,4)
tetra(6,6)
tetra(6,8)
tetra(6,10)
tetra(8,2)
tetra(8,4)
tetra(8,6)
tetra(8,8)
tetra(8,10)
tetra(10,2)
tetra(10,4)
tetra(10,6)
tetra(10,8)
tetra(10,10)