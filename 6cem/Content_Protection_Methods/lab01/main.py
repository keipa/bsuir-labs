import RC5
import getpass

print("RC5 Encoding Algorithm")
content_type = int(input("1 - for string encode\n2 - for file encode\n"))
if content_type == 1:
    content = bytes(input("content:"), "utf-8")
    password = bytes(getpass.getpass(), "utf-8")
    testRC = RC5.RC5(32, 12, password)
    print(str(content))
    code = testRC.encryptBytes(content)
    print(code)
    passwordDecrypt = bytes(getpass.getpass(), "utf-8")
    decryptRC = RC5.RC5(32, 12, passwordDecrypt)
    print(decryptRC.decryptBytes(code))
    input()
if content_type == 2:
    contentIn = bytes(input("input file name:"), "utf-8")
    contentOut = bytes(input("output file name:"), "utf-8")
    password = bytes(getpass.getpass(), "utf-8")
    testRC = RC5.RC5(32, 12, password)
    testRC.encryptFile(contentIn, contentOut)
    contentdec = bytes(input("decrypt file name:"), "utf-8")
    passwordDecrypt = bytes(getpass.getpass(), "utf-8")
    decryptRC = RC5.RC5(32, 12, passwordDecrypt)
    decryptRC.decryptFile(contentOut, contentdec)

