class List(object):
    def add(self, listitem):
        if self.count == 0:
            self.last = listitem
            self.count += 1
        else:
            self.last.link = listitem
            listitem.link = self.last
            self.count += 1

    def remove(self, value):
        index = 0
        curel = self.last
        while index < self.count:
            index += 1
            if curel.value == value:
                curel
                return True
            curel = curel.link
        return False

    def search(self, value):
        index = 0
        curel = self.last
        while index < self.count:
            index += 1
            if curel.value == value:
                return True
            curel = curel.link
        return False


    def __init__(self):
        self.count = 0
        self.last = 0


class ListItem(object):
    def __init__(self, value):
        self.value = value
        self.link = 0


# двусвязный список