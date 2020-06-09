from RC5 import *
from config import *
import md5


print("MD5 Authing...")
hash_in = md5.hash_file(CONTENT_INPUT, CONTENT_INPUT_HASHED)
print("MD5 Authing Complete")


print("RC5 Encrypt Algorithm")

password = bytes(input("password: "), "utf-8")
testRC = RC5(block_size, rounds, password)
testRC.encrypt_file(CONTENT_INPUT_HASHED, CONTENT_ENCRYPTED)
print("check \'{}\' file".format(CONTENT_ENCRYPTED))
passwordDecrypt = bytes(input("password: "), "utf-8")
decryptRC = RC5(block_size, rounds, passwordDecrypt)
decryptRC.decrypt_file(CONTENT_ENCRYPTED, CONTENT_DECRYPTED_HASHED)
print("check \'{}\' file".format(CONTENT_DECRYPTED_HASHED))

print("MD5 Authing...")
hash_out = md5.unhash_file(CONTENT_DECRYPTED_HASHED, CONTENT_DECRYPTED)
md5.check_hashes(hash_in, md5.get_hash(CONTENT_DECRYPTED))
print("MD5 Authing Complete")



