import string, random


def get_name():
    s = random.choice(string.ascii_letters) + random.choice(string.ascii_letters)
    return s


def arrproc(index, s):
    arr = []
    while s[index] != "]":
        index += 1
        tup = collector(index, s)
        arr.append(tup[1])
        index = tup[0]
    return (index+1, arr)

def dictproc(index, s):
    d = {}
    while s[index] != "}":
        index += 1
        # key
        key = collector(index, s)
        index = key[0]
        # value
        index += 1
        value = collector(index, s)
        index = value[0]
        d[key[1]] = value[1]
    return (index+1, d)


def strproc(index, s):
    str_collecting = ""
    index += 1
    while index < len(s):

        if s[index] == "\"":
            if index + 1 < len(s):
                if s[index+1] in string.ascii_letters or s[index + 1] in string.digits:
                    str_collecting += s[index]
                    index += 1
                    continue
                else:
                    return (index+1, str_collecting)
            else:
                return (index+1, str_collecting)
        str_collecting += s[index]
        index += 1


def intproc(index, s):
    int_collecting = ""
    while s[index] in string.digits or s[index] == ".":
        int_collecting += s[index]
        index += 1
        if not index < len(s):
            break
    return  (index, int(int_collecting))



def boolproc(index, s):
    pass

def get_attr(file):
    r = {}
    r = collector()
    # s = file.readline()


def collector(index, s):
    if s[index] == "[":
        return arrproc(index, s)

    if s[index] == "{":
        return dictproc(index, s)

    if s[index] == "t":
        index += 4
        return (index, True)

    if s[index] == "f":
        index += 5
        return (index, False)

    if s[index] == "\"":
        return strproc(index, s)

    if s[index] in string.digits:
        return intproc(index, s)

def cleaning(s):
    # return s.replace(" ", "").replace("\t", "").replace("\n", "")
    index = 0
    toclean = ""
    end = ""
    while index < len(s):
        while s[index] != "\"":
            toclean += s[index]
            index += 1
            if index >= len(s):
                break
        if index >= len(s):
            end += toclean.replace(" ", "").replace("\t", "").replace("\n", "")
            return end
        toclean += s[index]
        end += toclean.replace(" ", "").replace("\t", "").replace("\n", "")

        index += 1
        toclean = ""
        if index >= len(s):
            break
        while s[index] != "\"":
            end += s[index]
            index += 1
            if index >= len(s):
                break
        end += s[index]
        index += 1
    return end

def get_obj(path):
    s = ""
    index = 0

    with open(path, "r") as f:
        for line in f:
            s += line



    return collector(0, cleaning(s))[1]


def whatis(s):
    pass

    # print(s)




def main():
    print(get_obj("strfiles/jsoned.jsn"))




if __name__ == '__main__':
    main()