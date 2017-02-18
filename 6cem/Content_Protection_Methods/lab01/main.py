
import getpass


CONTENT_INPUT = "example"
CONTENT_ENCRYPTED = "exampleenc"
CONTENT_DECRYPTED = "exampleenc2"


class RC5:

    def __init__(self, block_size, rounds, key):
        self.block_size = block_size  # block size (32, 64 or 128 bits)
        self.rounds = rounds  # number of rounds (0 to 255)
        self.key = key  # key (0 to 2040 bits)

        # some useful constants
        self.T = 2 * (rounds + 1)
        self.w4 = block_size // 4
        self.w8 = block_size // 8
        self.mod = 2 ** self.block_size
        self.mask = self.mod - 1
        self.b = len(key)

        self.__keyAlign()
        self.__keyExtend()
        self.__shuffle()

    def __lshift(self, val, n):
        n %= self.block_size
        return ((val << n) & self.mask) | ((val & self.mask) >> (self.block_size - n))

    def __rshift(self, val, n):
        n %= self.block_size
        return ((val & self.mask) >> n) | (val << (self.block_size - n) & self.mask)

    def __const(self): # constants generation
        if self.block_size == 16:
            return (0xB7E1, 0x9E37) # return P, Q values
        elif self.block_size == 32:
            return (0xB7E15163, 0x9E3779B9)
        elif self.block_size == 64:
            return (0xB7E151628AED2A6B, 0x9E3779B97F4A7C15)

    def __keyAlign(self):
        if self.b == 0: # key is empty
            self.c = 1
        elif self.b % self.w8:
            self.key += b'\x00' * (self.w8 - self.b % self.w8) # fill key with \x00 bytes
            self.b = len(self.key)
            self.c = self.b // self.w8
        else:
            self.c = self.b // self.w8
        L = [0] * self.c
        for i in range(self.b - 1, -1, -1):
            L[i // self.w8] = (L[i // self.w8] << 8) + self.key[i]
        self.L = L


    def __keyExtend(self):
        P, Q = self.__const()
        self.S = [(P + i * Q) % self.mod for i in range(self.T)]

    def __shuffle(self):
        i, j, A, B = 0, 0, 0, 0
        for k in range(3 * max(self.c, self.T)):
            A = self.S[i] = self.__lshift((self.S[i] + A + B), 3)
            B = self.L[j] = self.__lshift((self.L[j] + A + B), A + B)
            i = (i + 1) % self.T
            j = (j + 1) % self.c


    def encryptBlock(self, data):
        A = int.from_bytes(data[:self.w8], byteorder='little')
        B = int.from_bytes(data[self.w8:], byteorder='little')
        A = (A + self.S[0]) % self.mod
        B = (B + self.S[1]) % self.mod
        for i in range(1, self.rounds + 1):
            A = (self.__lshift((A ^ B), B) + self.S[2 * i]) % self.mod
            B = (self.__lshift((A ^ B), A) + self.S[2 * i + 1]) % self.mod
        return (A.to_bytes(self.w8, byteorder='little')
                + B.to_bytes(self.w8, byteorder='little'))


    def decryptBlock(self, data):
        A = int.from_bytes(data[:self.w8], byteorder='little')
        B = int.from_bytes(data[self.w8:], byteorder='little')
        for i in range(self.rounds, 0, -1):
            B = self.__rshift(B - self.S[2 * i + 1], A) ^ A
            A = self.__rshift(A - self.S[2 * i], B) ^ B
        B = (B - self.S[1]) % self.mod
        A = (A - self.S[0]) % self.mod
        return (A.to_bytes(self.w8, byteorder='little')
                + B.to_bytes(self.w8, byteorder='little'))

    def encryptFile(self, inpFileName, outFileName):
        with open(inpFileName, 'rb') as inp, open(outFileName, 'wb') as out:
            run = True
            while run:
                text = inp.read(self.w4)
                if not text:
                    break
                if len(text) != self.w4:
                    text = text.ljust(self.w4, b'\x00')
                    run = False
                text = self.encryptBlock(text)
                out.write(text)

    def decryptFile(self, inpFileName, outFileName):
        with open(inpFileName, 'rb') as inp, open(outFileName, 'wb') as out:
            run = True
            while run:
                text = inp.read(self.w4)
                if not text:
                    break
                if len(text) != self.w4:
                    run = False
                text = self.decryptBlock(text)
                if not run:
                    text = text.rstrip(b'\x00')
                out.write(text)







# print("RC5 Encrypt Algorithm")
#
#
# password = bytes(getpass.getpass(), "utf-8")
#
# testRC = RC5(32, 12, password)
# testRC.encryptFile(CONTENT_INPUT, CONTENT_ENCRYPTED)
#
# passwordDecrypt = bytes(getpass.getpass(), "utf-8")
# decryptRC = RC5(32, 12, passwordDecrypt)
# decryptRC.decryptFile(CONTENT_ENCRYPTED, CONTENT_DECRYPTED)




