import getpass

CONTENT_INPUT = "example"
CONTENT_ENCRYPTED = "exampleENC"
CONTENT_DECRYPTED = "exampleDEC"

# Rivest Cipher, либо Ron's Code
class RC5:
    def __init__(self, block_size, rounds, key):
        self.block_size = block_size  # block size (32, 64 or 128 bits)
        self.rounds = rounds  # number of rounds (0 to 255)
        self.key = key  # key (0 to 2040 bits)

        self.T = 2 * (rounds + 1)
        self.w4 = block_size // 4
        self.w8 = block_size // 8
        self.mod = 2 ** self.block_size
        self.mask = self.mod - 1
        self.b = len(key)

        self.key_alignment()  # Выравнивание ключа
        self.init_keys_array()  # Инициализация массива расширенных ключей
        self.shuffle()  # Перемешивание

    def leftshift(self, val, n):   #   операция циклического сдвига на n битов влево
        n %= self.block_size
        return ((val << n) & self.mask) | ((val & self.mask) >> (self.block_size - n))

    def rightshift(self, val, n):
        n %= self.block_size
        return ((val & self.mask) >> n) | (val << (self.block_size - n) & self.mask)

    def __const(self):  # constants generation
        if self.block_size == 16:
            return (0xB7E1, 0x9E37)
            # return P, Q values P = ready(odd (f-1)*2**w) золотое сечение Q = odd((e-1)*2**w)

    def key_alignment(self):
        if self.b == 0:  # key is empty
            self.c = 1
        elif self.b % self.w8:
            self.key += b'\x00' * (self.w8 - self.b % self.w8)  # fill key with \x00 bytes
            self.b = len(self.key)
            self.c = self.b // self.w8
        else:
            self.c = self.b // self.w8
        L = [0] * self.c
        for i in range(self.b - 1, -1, -1):
            L[i // self.w8] = (L[i // self.w8] << 8) + self.key[i]
        self.L = L  # массива с ключами

    def init_keys_array(self):
        P, Q = self.__const()
        self.S = [(P + i * Q) % self.mod for i in range(self.T)]  # массив с константами

    def shuffle(self):  # перемешивание массива с константами и массива с ключами
        i, j, A, B = 0, 0, 0, 0
        for k in range(3 * max(self.c, self.T)):
            A = self.S[i] = self.leftshift((self.S[i] + A + B), 3)
            B = self.L[j] = self.leftshift((self.L[j] + A + B), A + B)
            i = (i + 1) % self.T
            j = (j + 1) % self.c

    def encrypt_block(self, data):
        A = int.from_bytes(data[:self.w8], byteorder='little')
        B = int.from_bytes(data[self.w8:], byteorder='little')
        A = (A + self.S[0]) % self.mod  # операции нулевого раунда
        B = (B + self.S[1]) % self.mod  # операции нулевого раунда
        for i in range(1, self.rounds + 1):
            A = (self.leftshift((A ^ B), B) + self.S[2 * i]) % self.mod   # шифрование Фейстель
            B = (self.leftshift((A ^ B), A) + self.S[2 * i + 1]) % self.mod
        return A.to_bytes(self.w8, byteorder='little') + B.to_bytes(self.w8, byteorder='little')

    def encrypt_file(self, inp_file_name, out_file_name):
        with open(inp_file_name, 'rb') as inp, open(out_file_name, 'wb') as out:
            run = True
            while run:
                text = inp.read(self.w4)
                if not text:
                    break
                if len(text) != self.w4:
                    text = text.ljust(self.w4, b'\x00')
                    run = False
                text = self.encrypt_block(text)
                out.write(text)

    def decrypt_block(self, data):
        A = int.from_bytes(data[:self.w8], byteorder='little')
        B = int.from_bytes(data[self.w8:], byteorder='little')
        for i in range(self.rounds, 0, -1):
            B = self.rightshift(B - self.S[2 * i + 1], A) ^ A
            A = self.rightshift(A - self.S[2 * i], B) ^ B
        B = (B - self.S[1]) % self.mod
        A = (A - self.S[0]) % self.mod
        return (A.to_bytes(self.w8, byteorder='little')
                + B.to_bytes(self.w8, byteorder='little'))

    def decrypt_file(self, inp_file_name, out_file_name):
        with open(inp_file_name, 'rb') as inp, open(out_file_name, 'wb') as out:
            run = True
            while run:
                text = inp.read(self.w4)
                if not text:
                    break
                if len(text) != self.w4:
                    run = False
                text = self.decrypt_block(text)
                if not run:
                    text = text.rstrip(b'\x00')
                out.write(text)


print("RC5 Encrypt Algorithm")

password = bytes(getpass.getpass(), "utf-8")

testRC = RC5(16, 12, password)
testRC.encrypt_file(CONTENT_INPUT, CONTENT_ENCRYPTED)

passwordDecrypt = bytes(getpass.getpass(), "utf-8")

decryptRC = RC5(16, 12, passwordDecrypt)
decryptRC.decrypt_file(CONTENT_ENCRYPTED, CONTENT_DECRYPTED)




