#!/usr/bin/python3

import sys


class StringField(object):
    def __call__(self):
        return str

    def __eq__(self, operand):
        return str == type(operand)

    def get_type(self):
        return str


class IntField(object):
    def __call__(self):
        return int

    def __eq__(self, operand):
        return int == type(operand)

    def get_type(self):
        return int


class ListField(object):
    def __call__(self):
        return list

    def __eq__(self, operand):
        return list == type(operand)

    def get_type(self):
        return list


class TupleField(object):
    def __call__(self):
        return tuple

    def __eq__(self, operand):
        return tuple == type(operand)

    def get_type(self):
        return tuple


class ModelMeta(type):
    def __new__(meta, name, bases, dict):
        def _check(self, attr, value):
            if attr in self.defaults:
                if not isinstance(value, self.defaults[attr]):
                    raise TypeError('%s cannot be %s' % (attr, type(value)))
            else:
                self.defaults[attr] = type(value)

        def _setattr(self, attr, value):
            _check(self, attr, value)
            object.__setattr__(self, attr, value)

        cls = type.__new__(meta, name, bases, dict)

        # Set up default type for every attribute
        cls.defaults = {}
        for name, value in dict.items():
            if isinstance(value, (StringField, IntField,
                                  ListField, TupleField)):
                cls.defaults[name] = value()

        cls.__setattr__ = _setattr
        return cls

    def __call__(cls, **kwargs):
        obj = type.__call__(cls)

        for attr, value in kwargs.items():
            if attr in cls.defaults:
                if isinstance(value, cls.defaults[attr]):
                    setattr(obj, attr, value)
                else:
                    raise TypeError
            else:
                setattr(obj, attr, value)

        return obj


class Example(object, metaclass=ModelMeta):
    aaa = IntField()
    bbb = StringField()


class InheriteExample(Example):
    ccc = IntField()


def main():
    a = Example(bbb="Wheee!", aaa=777)
    print(a.aaa, a.bbb)
    a.bbb = 2
    a.aaa = 13412
    print(a.aaa, a.bbb)

    print()

    b = InheriteExample(aaa=777, bbb="Wheee!", ccc=111)
    print(b.aaa, b.bbb, b.ccc)
    b.bbb = "qwerfg111"
    b.aaa = 1456
    b.ccc = 11111
    print(b.aaa, b.bbb, b.ccc)


if __name__ == "__main__":
    sys.exit(main())