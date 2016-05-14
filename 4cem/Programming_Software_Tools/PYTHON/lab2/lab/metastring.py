class IntField(object):
    def __call__(self, *args, **kwargs):
        return 0

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
    def __new__(cls, name, bases, attrs):
        return super(ModelCreator, cls).__new__(cls, name, bases, attrs)

    def __call__(self, *args, **kwargs):
        obj = type.__call__(self)
        for each in kwargs:
            if isinstance(getattr(obj, each), IntField):
                if isinstance(kwargs[each], int):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
            if isinstance(getattr(obj, each), IntField):
                if isinstance(kwargs[each], int):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
            if isinstance(getattr(obj, each), StringField):
                if isinstance(kwargs[each], str):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
            if isinstance(getattr(obj, each), TupleField):
                if isinstance(kwargs[each], tuple):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
            if isinstance(getattr(obj, each), BoolField):
                if isinstance(kwargs[each], bool):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
            if isinstance(getattr(obj, each), DictField):
                if isinstance(kwargs[each], dict):
                    setattr(obj, each, int(kwargs[each]))
                else:
                    raise TypeError
        return obj

    def __getattr__(self, item):
        return 0

class Cls(object, metaclass=ModelCreator):
    i = IntField()
    s = StringField()
    l = ListField()
    t = TupleField()
    b = BoolField()
    d = DictField()


def main():
    f = Cls()
    print(f.i)
    b = Cls()

if __name__ == '__main__':
    main()
