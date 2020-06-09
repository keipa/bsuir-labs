# python lsb.py --encrypt
# python lsb.py --restore
# see the config.py also
import cv2


def adding_prefix(val, limit):
    binval = bin(val)[2:]
    if len(binval) > limit:
        print "Text is too big"
    while len(binval) < limit:
        binval = "0" + binval
    return binval


def byte_value(val):
    return adding_prefix(val, 8)


class LSB():
    def __init__(self, im):
        self.image = im
        self.height, self.width = im.shape[:2]
        self.size = self.width * self.height
        self.channels_count = len(im[0, 0])
        self.ones_masks = [1, 2, 4, 8, 16, 32, 64, 128]
        self.current_one_mask = self.ones_masks.pop(0)
        self.zeros_masks = [254, 253, 251, 247, 239, 223, 191, 127]
        self.current_zero_mask = self.zeros_masks.pop(0)
        self.current_x = 0
        self.current_y = 0
        self.current_channel = 0

    def save_image(self, filename):
        cv2.imwrite(filename, self.image)

    def put_bits_into_cell(self, bits):
        for c in bits:
            val = list(self.image[self.current_y, self.current_x])
            if int(c) == 1:
                val[self.current_channel] = int(val[self.current_channel]) | self.current_one_mask
            else:
                val[self.current_channel] = int(val[self.current_channel]) & self.current_zero_mask
            self.image[self.current_y, self.current_x] = tuple(val)
            self.get_next_slot()

    def get_next_slot(self):
        if self.current_channel == self.channels_count - 1:
            self.current_channel = 0
            if self.current_x == self.width - 1:
                self.current_x = 0
                if self.current_y == self.height - 1:
                    self.current_y = 0
                    if self.current_one_mask == 128:
                        raise Exception("Text is too big")
                    else:
                        self.current_one_mask = self.ones_masks.pop(0)
                        self.current_zero_mask = self.zeros_masks.pop(0)
                else:
                    self.current_y += 1
            else:
                self.current_x += 1
        else:
            self.current_channel += 1

    def read_bit(self):
        val = self.image[self.current_y, self.current_x][self.current_channel]
        val = int(val) & self.current_one_mask
        self.get_next_slot()
        if val > 0:
            return "1"
        else:
            return "0"

    def read_byte(self):
        return self.read_bits(8)

    def read_bits(self, nb):
        bits = ""
        for i in range(nb):
            bits += self.read_bit()

        return bits

    def hiding_text(self, filename):
        with open(filename, 'rb') as f:
            text = f.read()
        l = len(text)
        if self.width * self.height * self.channels_count < l + 64:
            print "Image too small"
        self.put_bits_into_cell(adding_prefix(l, 64))
        for byte in text:
            self.put_bits_into_cell(byte_value(ord(byte)))

    def restoring_text(self):
        output = ""
        for i in range(int(self.read_bits(64), 2)):
            output += chr(int(self.read_byte(), 2))
        return output


def hide_text_into_image(original_image, text_to_hide, encrypted_image):
    pixel_array = cv2.imread(original_image)
    encryption_factory = LSB(pixel_array)
    encryption_factory.hiding_text(text_to_hide)
    encryption_factory.save_image(encrypted_image)


def restore_text_from_image(encrypted_image, output_text):
    pixel_array = cv2.imread(encrypted_image)
    encryption_factory = LSB(pixel_array)
    with open(output_text, "wb") as f:
        f.write(encryption_factory.restoring_text())



