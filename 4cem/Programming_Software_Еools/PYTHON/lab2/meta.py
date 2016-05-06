class UpperAttrMetaclass(type):
    def __new__(cls, name, bases, attrs):
        attrs = UpperAttrMetaclass.give_me_attrs(cls, attrs["path"], attrs)
        print(attrs)
        return super(UpperAttrMetaclass, cls).__new__(cls, name, bases, attrs)


    def give_me_attrs(cls, path, attrs):
        with open(path, "r") as f:
            for line in f:
                try:
                    attrs[line.split("_")[0]] = int(line.split("_")[1].replace("\n", ""))
                except:
                    attrs[line.split("_")[0]] = line.split("_")[1].replace("\n", "")
        return attrs


class Cls(object, metaclass=UpperAttrMetaclass("")):

    # def __getattr__(self, item):
    #
    # def __init__(self, path):
    #     self.p = path
    # Cls = metaclass.__new__(cls, name, bases, namespace, **kargs)
    path = "strfiles/attr.txt"
        # def __new__(cls, *args, **kwargs):
        #     cls.peppepe = args[0]
        #
    def __setattr__(self, key, value):
        Cls.attrs[key] = value
    # def __call__(self, *args, **kwargs):
    #     Cls.peppepe = args[0]

# print("start")
# path = "strfiles/attr.txt"

# Cls = UpperAttrMetaclass.__new__(cls, name, bases, namespace, **kargs)

f = Cls()
Cls.path = "none"
b = Cls()
# print(f.b)

