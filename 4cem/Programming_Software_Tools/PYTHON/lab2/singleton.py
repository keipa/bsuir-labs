class Singleton:
    def __init__(self, decorated):
        self._decorated = decorated

    def __call__(self):
        try:
            return self._instance
        except AttributeError:
            self._instance = self._decorated()
            return self._instance


@Singleton
class Foo:
    g = 0
    def __init__(self):
        print('Foo created')

a = Foo()
b = Foo()

a.g = 5
print(b.g, " ", a.g)
