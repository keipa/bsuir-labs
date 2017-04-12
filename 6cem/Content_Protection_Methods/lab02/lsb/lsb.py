# https://github.com/RobinDavid/LSB-Steganography/blob/master/LSBSteg.py
# python lab2.py -image in.bmp -binary text.txt -steg-out out.bmp
# python lab2.py -steg-image out.bmp -out retext.txt
import cv2
import config

def adding_prefix(val, limit):
    # Return the binary value of an int as a byte
    binval = bin(val)[2:]
    if len(binval) > limit:
        print "Text is too big"
    while len(binval) < limit:
        binval = "0" + binval
    return binval


class LSB():

    def __init__(self, im):
        self.image = im
        self.height, self.width = im.shape[:2]
        self.size = self.width * self.height
        self.channels_count = len(im[0, 0])

        self.ones_masks = [1, 2, 4, 8, 16, 32, 64, 128]
        # Mask used to put one ex:1->00000001, 2->00000010 .. associated with OR bitwise
        self.current_one_mask = self.ones_masks.pop(0)  # Will be used to do bitwise operations

        self.zeros_masks = [254, 253, 251, 247, 239, 223, 191, 127]
        # Mask used to put zero ex:254->11111110, 253->11111101 .. associated with AND bitwise
        self.current_zero_mask = self.zeros_masks.pop(0)

        self.current_x = 0  # Current width position
        self.current_y = 0  # Current height position
        self.current_channel = 0  # Current channel position

    def save_image(self, filename):  # Save the image using the given filename
        cv2.imwrite(filename, self.image)

    def putBinaryValue(self, bits):  # Put the bits in the image
        for c in bits:
            val = list(self.image[self.current_y, self.current_x])  # Get the pixel value as a list
            if int(c) == 1:
                val[self.current_channel] = int(val[self.current_channel]) | self.current_one_mask  # OR with maskONE
            else:
                val[self.current_channel] = int(val[self.current_channel]) & self.current_zero_mask  # AND with maskZERO

            self.image[self.current_y, self.current_x] = tuple(val)
            self.get_next_slot()  # Move "cursor" to the next space

    def get_next_slot(self):  # Move to the next slot were information can be taken or put
        if self.current_channel == self.channels_count - 1:  # Next Space is the following channel
            self.current_channel = 0
            if self.current_x == self.width - 1:  # Or the first channel of the next pixel of the same line
                self.current_x = 0
                if self.current_y == self.height - 1:  # Or the first channel of the first pixel of the next line
                    self.current_y = 0
                    if self.current_one_mask == 128:  # Mask 1000000, so the last mask
                        print "smth went wrong("
                    else:  # Or instead of using the first bit start using the second and so on..
                        self.current_one_mask = self.ones_masks.pop(0)
                        self.current_zero_mask = self.zeros_masks.pop(0)
                else:
                    self.current_y += 1
            else:
                self.current_x += 1
        else:
            self.current_channel += 1

    def readBit(self):  # Read a single bit int the image
        val = self.image[self.current_y, self.current_x][self.current_channel]
        val = int(val) & self.current_one_mask
        self.get_next_slot()
        if val > 0:
            return "1"
        else:
            return "0"

    def readByte(self):
        return self.readBits(8)

    def readBits(self, nb):  # Read the given number of bits
        bits = ""
        for i in range(nb):
            bits += self.readBit()
        return bits

    def byteValue(self, val):
        return adding_prefix(val, 8)

    def hiding_text(self, filename):
        with open(filename, 'rb') as f:
            bin = f.read()
        l = len(bin)
        if self.width * self.height * self.channels_count < l + 64:
            print "Image too small"
        self.putBinaryValue(adding_prefix(l, 64))
        for byte in bin:
            self.putBinaryValue(self.byteValue(ord(byte)))

    def restoring_text(self):
        l = int(self.readBits(64), 2)
        output = ""
        for i in range(l):
            output += chr(int(self.readByte(), 2))
        return output


def binary_steg_hide(image, binary, result):
    carrier = cv2.imread(image)
    steg = LSB(carrier)
    steg.hiding_text(binary)
    steg.save_image(result)


def binary_steg_reveal(steg_image, out):
    inp = cv2.imread(steg_image)
    steg = LSB(inp)
    bin = steg.restoring_text()
    # cv2.imwrite(out)
    with open(out, "wb") as f:
        f.write(bin)


import argparse

parser = argparse.ArgumentParser(
    description='This python program applies LSB Steganography to an image and some type of input')


def main(av):
    bgroup = parser.add_argument_group("Hide binary with steg")
    bgroup.add_argument('-image', help='Provide the original image')
    bgroup.add_argument('-binary', help='The binary file to be obfuscated in the image')
    bgroup.add_argument('-steg-out', help='The resulting steganographic image')
    bgroup = parser.add_argument_group("Reveal binary")
    bgroup.add_argument('-steg-image', help='The steganographic image')
    bgroup.add_argument('-out', help='The original binary')

    args = parser.parse_args(av[1:])

    if len(av) == 7:
        binary_steg_hide(args.image, args.binary, args.steg_out)
    elif len(av) == 5:
        binary_steg_reveal(args.steg_image, args.out)
    else:
        print "Usage: '", av[0], "-h' for help", "\n", args


if __name__ == "__main__":
    from sys import argv as av

    main(av)
