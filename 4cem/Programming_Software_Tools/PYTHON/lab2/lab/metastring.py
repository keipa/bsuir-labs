

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


class ModelCreator(type):
    class IntField(object):
        def __init__(self):
            self.default = 0

        def set_default(self, value):
            if isinstance(value, int):
                self.default = value
            else:
                raise TypeError("your entered value is not")

        def __set__(self, instance, value):
            if isinstance(instance, int):
                self.default = value
            else:
                raise TypeError

        def __get__(self, instance, owner):
            return self.default

    def __new__(cls, name, bases, attrs):

        def _setcustom(self, attr, value):
            pass

        cls.__setattr__ = _setcustom

        return super(ModelCreator, cls).__new__(cls, name, bases, attrs)


    # def __getattr__(self, key, value):
    #     if isinstance(key, IntField):
    #         print("e")
    #     return 2
    # def _setattr(self, key, value):

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
    i = ModelCreator.IntField()
    s = StringField()
    l = ListField()
    t = TupleField()
    b = BoolField()
    d = DictField()

    # def __getattr__(self, item):
    #     return 5


def main():
    f = Cls()
    print(f.i)
    f.i = ';'

    b = Cls()

if __name__ == '__main__':
    main()
