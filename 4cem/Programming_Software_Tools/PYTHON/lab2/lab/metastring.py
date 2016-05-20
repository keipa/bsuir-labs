

class BoolField(object):
    def __call__(cls, *args, **kwargs):
        return False


class DictField(object):
    def __call__(cls, *args, **kwargs):
        return {}


class TupleField(object):
    def __call__(cls, *args, **kwargs):
        return ()


class ListField(object):
    def __call__(cls, *args, **kwargs):
        return []


class StringField(object):
    def __call__(cls, *args, **kwargs):
        return ""


class IntField(object):
    def __init__(self):
        self.default = 0

    # def set_default(self, value):
    #     if isinstance(value, int):
    #         self.default = value
    #     else:
    #         raise TypeError("your entered value is not")
    #
    def __call__(self, *args, **kwargs):
        return True

    def __set__(self, instance, value):
        self.default = value
        return True

    def __get__(self, instance, owner):
        return self.default

    # def __set__(self, instance, value):
    #     if isinstance(instance, int):
    #         self.default = value
    #     else:
    #         raise TypeError

    # def __get__(self, instance, owner):
    #     return self.default


class ModelCreator(type):

    def __new__(cls, name, bases, attrs):
        def _check(self, attr, value):
            if attr in self.defaults:
                if not isinstance(value, self.defaults[attr]):
                    raise TypeError('%s cannot be %s' % (attr, type(value)))
            else:
                self.defaults[attr] = type(value)

        def _setattr(self, attr, value):
            _check(self, attr, value)
            object.__setattr__(self, attr, value)

        # cls.__getattr__ = getcustom

        new_class = type.__new__(cls, name, bases, attrs)
        # Set up default type for every attribute
        new_class.defaults = {}

        for name, value in attrs.items():
            if isinstance(value, IntField):
                new_class.defaults[name] = value()

        new_class.__setattr__ = _setattr
        # new_class.__getattr__ = _getcustom
        return new_class


    # def __getattr__(self, key, value):
    #     if isinstance(key, IntField):
    #         print("e")
    #     return 2
    # def _setattr(self, key, value):







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



    # def __call__(self, *args, **kwargs):
    #     obj = type.__call__(self)
    #     for each in kwargs:
    #         if isinstance(getattr(obj, each), IntField):
    #             try:
    #                 getattr(obj, each).set_default(int(kwargs[each]))
    #             except:
    #                 raise TypeError
    #
    #
    #         if isinstance(getattr(obj, each), StringField):
    #             if isinstance(kwargs[each], str):
    #                 setattr(obj, each, int(kwargs[each]))
    #             else:
    #                 raise TypeError
    #         if isinstance(getattr(obj, each), TupleField):
    #             if isinstance(kwargs[each], tuple):
    #                 setattr(obj, each, int(kwargs[each]))
    #             else:
    #                 raise TypeError
    #         if isinstance(getattr(obj, each), BoolField):
    #             if isinstance(kwargs[each], bool):
    #                 setattr(obj, each, int(kwargs[each]))
    #             else:
    #                 raise TypeError
    #         if isinstance(getattr(obj, each), DictField):
    #             if isinstance(kwargs[each], dict):
    #                 setattr(obj, each, int(kwargs[each]))
    #             else:
    #                 raise TypeError
    #     return obj

    # def __getattr__(self, item):
    #     return 0
class Cls(object, metaclass=ModelCreator):
    i = IntField()
    # s = StringField()
    # l = ListField()
    # t = TupleField()
    # b = BoolField()
    # d = DictField()

    # def __getattr__(self, item):
    #     return 5


def main():
    f = Cls()
    print(f.i)
    f.i = 5

    b = Cls()

if __name__ == '__main__':
    main()
