from unittest import TestCase
import lab.generate
import lab.cashed
import lab.vector
import time
import lab.defaultdict
import lab.sort
import lab.meta
import lab.logger
import lab.my_xrange
import lab.to_json
import lab.from_json
import lab.seq


class TestGenerate(TestCase):
    def test_generate_correct(self):
        line_count = 2
        lab.generate.generate(3, " ", line_count, "\n", "a", 3)
        with open("strfiles/genrated.txt", "r") as f:
            for line in f:
                line_count -= 1
        self.assertTrue(line_count == 0)

    def test_generate_incorrect(self):
        line_count = 2
        lab.generate.generate(5, " ", line_count, "\n", "a", 3)
        with open("strfiles/genrated.txt", "r") as f:
            for line in f:
                line_count -= 1
        self.assertTrue(line_count == 0)

    def test_cashed1(self):
        start_time = time.time()
        i = lab.cashed.one(2)
        one_execute = time.time()
        j = lab.cashed.one(2)
        now = time.time()
        print(now - start_time)
        print((now - one_execute)*2)
        self.assertTrue(now - one_execute < (one_execute - start_time)*2)

    def test_cashed2(self):
        start_time = time.time()
        i = lab.cashed.one(2)
        one_execute = time.time()
        j = lab.cashed.main()
        now = time.time()
        self.assertTrue(now - now <= (one_execute - start_time)*2)

    def test_vector(self):
        a = lab.vector.Vector(4)
        b = lab.vector.Vector(3)
        with self.assertRaises(TypeError):
            a = a*b

    def test_vector2(self):
        a = lab.vector.Vector(4)
        a += 3
        self.assertTrue(a.x == [3, 3, 3, 3])

    def test_default(self):
        d = lab.defaultdict.Defaul_dict(0)
        d["3"]["ew2"]["2"] = None
        self.assertFalse(d["3"]["ew2"]["2"] == "kek")

    def test_default2(self):
        d = lab.defaultdict.Defaul_dict(0)
        d["1"] = 2
        d["2"] = 5
        self.assertTrue(d["1"] + d["2"] == 7)

    def test_sort(self):
        self.assertTrue(lab.sort.checking("strfiles/sorted.txt"))

    def test_sort2(self):
        self.assertFalse(lab.sort.checking("strfiles/genrated.txt"))

    def test_meta(self):
            self.assertFalse(lab.meta.Cls.a != 1)

    def test_meta2(self):
        self.assertTrue(lab.meta.Cls.b == 2)

    def test_logger(self):
        sam = lab.logger.Sample()
        sam.set_logger_format(name=True, ret=True)
        sam.sample(3, 3)
        sam.sample(3, 1)
        sam.sample(3, 2)
        print(str(sam.log_array))
        self.assertTrue(len(sam.log_array) == 3)

    def test_logger2(self):
        sam = lab.logger.Sample()
        sam.sample(3, 3)
        print(str(sam.log_array))
        self.assertTrue(len(sam.log_array) == 1)

    def test_xrange(self):
        self.assertTrue(next(reversed(lab.my_xrange.xrange(100500))) == 100499)

    def test_xrange2(self):
        self.assertTrue(lab.my_xrange.xrange(100500)[63] == 63)

    def test_tojson(self):
        t = ["1", ["2", [3, 2, True, 'ke', [3, 5]]], 3, 4, 5]
        lab.to_json.my_json(t)
        print(t)
        print(lab.from_json.get_obj("strfiles/jsoned3.jsn"))
        self.assertTrue(lab.from_json.get_obj("strfiles/jsoned3.jsn") == t)


    def test_tojson2(self):
        t = [1,2,"kww'wwq", {"1":True}]
        lab.to_json.my_json(t)
        print(t)
        print(lab.from_json.get_obj("strfiles/jsoned3.jsn"))
        self.assertTrue(lab.from_json.get_obj("strfiles/jsoned3.jsn") == t)

    def test_seq1(self):
        a = lab.seq.Seq([1, 2, 5, 7, 8])

        def custom_2(x):
            if x < 2:
                return False
            else:
                return True
        self.assertTrue(a.custom_filter(custom_2) == [2, 5, 7, 8])

    def test_seq2(self):
        a = lab.seq.Seq([i for i in range(10)])

        def custom_2(x):
            if x % 2:
                return False
            else:
                return True
        print(a.custom_filter(custom_2))
        self.assertTrue(a.custom_filter(custom_2) == [0, 2, 4, 6, 8])
