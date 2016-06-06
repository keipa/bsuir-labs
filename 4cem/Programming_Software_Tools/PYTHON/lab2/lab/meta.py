class UpperAttrMetaclass(type):
    def __new__(cls, name, bases, attr):
        attr = UpperAttrMetaclass.give_me_attrs(cls, attr["path"], attr)
        print(attr)
        return super(UpperAttrMetaclass, cls).__new__(cls, name, bases, attr)

    def give_me_attrs(cls, path, attr):
        with open(path, "r") as f:
            for line in f:
                try:
                    attr[line.split("_")[0]] = int(line.split("_")[1].replace("\n", ""))
                except e:
                    attr[line.split("_")[0]] = line.split("_")[1].replace("\n", "")
        return attr


class Cls(object, metaclass=UpperAttrMetaclass):
    path = "strfiles/attr.txt"
    def __setattr__(self, key, value):
        Cls.attrs[key] = value

f = Cls()
Cls.path = "none"
b = Cls()


