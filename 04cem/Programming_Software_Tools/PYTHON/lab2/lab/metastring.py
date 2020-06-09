class BoolField(object):
    def __call__(self):
        return False


class DictField(object):
    def __call__(self):
        return {}


class TupleField(object):
    def __call__(self):
        return ()


class ListField(object):
    def __call__(self):
        return []


class StringField(object):
    def __call__(self):
        return str


class IntField(object):
        def __call__(self):
            return int


class ModelCreator(type):
    def __new__(cls, name, bases, attrs):
        custom = type.__new__(cls, name, bases, attrs)
        custom.defaults = {}
        for name, value in attrs.items():
            if isinstance(value, (IntField, StringField, TupleField, ListField, BoolField, DictField)):
                custom.defaults[name] = value()
        custom.__setattr__ = ModelCreator.custom_setattr
        return custom

    def type_checking(self, attr, value):
        if attr in self.defaults:
            if not isinstance(value, self.defaults[attr]):
                print("Value not setted")
                raise TypeError("Type do not match")
        else:
            self.defaults[attr] = type(value)

    def custom_setattr(self, attr, value):
        ModelCreator.type_checking(self, attr, value)
        object.__setattr__(self, attr, value)

    def __call__(cls, **kwargs):
        obj = type.__call__(cls)
        for attr, value in kwargs.items():
            if attr in cls.defaults:
                if isinstance(value, cls.defaults[attr]):
                    setattr(obj, attr, value)
                    print("Value setted")
                else:
                    raise TypeError
            else:
                setattr(obj, attr, value)
        return obj


class Cls(object, metaclass=ModelCreator):
    i = IntField()
    s = StringField()
    l = ListField()
    t = TupleField()
    b = BoolField()
    d = DictField()
    # def __getattr__(self, item):
    #     return 5


def main():
    f = Cls(i=5, s="h")
    f.s = 2
    f.i = "h"


if __name__ == '__main__':
    main()
