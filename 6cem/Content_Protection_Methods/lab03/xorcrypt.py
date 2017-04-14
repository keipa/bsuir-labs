#!/usr/bin/python


class AbstractCrypt(object):
    input_stream = None
    output_stream = None
    hash_function = None
    key = ''
    block_size = 16
    key_index = 0
    total_data = ''

    def __init__(self, _in, _out, _hash):
        self.input_stream = _in
        self.output_stream = _out
        if _hash is not None:
            self.hash_function = _hash
        else:
            self.hash_function = lambda x: ''

    def set_key(self, _key):
        self.key = _key

    def _encrypt(self):
        pass

    def encrypt(self):
        hash_len = len(self.hash_function('test'))

        if hash_len > 0:
            data = self.input_stream.read()
            self.output_stream.write(self.hash_function(data))
            self.input_stream.seek(0)

        self._encrypt()

        self.total_data = ''

    def _decrypt(self):
        pass

    def decrypt(self):
        hash_len = len(self.hash_function('test'))

        hash_str = ''
        if hash_len > 0:
            hash_str = self.input_stream.read(hash_len)

        self.input_stream.seek(hash_len)
        self._decrypt()

        if hash_len > 0:
            cur_hash = self.hash_function(self.total_data)
            if cur_hash != hash_str:
                raise ValueError("Integrity check failed: expected {}, calculated {}".format(hash_str, cur_hash))

    def close_streams(self):
        self.input_stream.close()
        self.output_stream.close()


class XorCrypt(AbstractCrypt):
    def _xorify_byte(self, char):
        xored_byte = chr(ord(char) ^ ord(self.key[self.key_index]))
        self.key_index = (self.key_index + 1) % len(self.key)
        return xored_byte

    def _xorify_block(self, block):
        return ''.join([self._xorify_byte(b) for b in block])

    def _encrypt(self):
        block = self.input_stream.read(self.block_size)
        while block:
            decrypted_block = self._xorify_block(block)
            self.total_data += decrypted_block
            self.output_stream.write(decrypted_block)
            block = self.input_stream.read(self.block_size)

    def _decrypt(self):
        self._encrypt()
