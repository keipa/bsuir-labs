#!/usr/bin/python
import xorcrypt
import myhash


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", type=str, help="input file name", default='')
    parser.add_argument("output_file", type=str, help="output file name", default='')
    parser.add_argument("enc_key", type=str, help="encryption key", default='')
    parser.add_argument("-d", "--decrypt", action="store_true", help="enable decryption mode")
    parser.add_argument("--hash", action="store_true", help="do not encrypt, just calculate hash")
    parser.add_argument("--to-hash", type=str, help="string to calculate hash from")
    args = parser.parse_args()

    if args.hash and args.to_hash:
        print myhash.calc_md5(args.to_hash)
    else:
        crypt = xorcrypt.XorCrypt(
            open(args.input_file, 'rb'),
            open(args.output_file, 'wb'),
            myhash.calc_md5
        )
        crypt.set_key(args.enc_key)

        if args.decrypt:
            crypt.decrypt()
        else:
            crypt.encrypt()

        crypt.close_streams()
