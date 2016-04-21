def my_json(obj, *args):
    string = ""
    # if len(args) != 0:
    #     if args[0] == True:
    #         print("rise unknown ")
    what_the_obj = str(type(obj))
    print(distributor(what_the_obj, obj, 0))


def tabstring(ret, deep):
    split = ret.split("\n")
    for each in range(len(split)):
        split[each] = "\t"*deep+split[each]
    ret = ""
    for each in split:
        ret += each + "\n"
    return ret


def distributor(objtype, obj, deep, *args):
    ret_string = ""
    if objtype == "<class 'dict'>":
        ret_string += "{\n"
        deep += 1
        ret_string += dict_processing(obj, deep)
        ret_string += "\t"*(deep-1)+"}"
        deep -= 1
    elif objtype == "<class 'list'>" or objtype == "<class 'tuple'>":
        ret_string += "[\n"
        deep += 1
        ret_string += list_tuple_processing(obj, deep)
        ret_string += "\t"*(deep-1)+"]"
        deep -= 1
    elif objtype == "<class 'str'>":
        ret_string += string_processing(obj)
    elif objtype == "<class 'int'>" or objtype == "<class 'float'>":
        ret_string += num_processing(obj)
    elif objtype == "<class 'bool'>":
        ret_string += true_false_processing(obj)
    elif objtype == "<class 'NoneType'>":
        ret_string += null_processing()
    else:
        if len(args) != 0:
            if args[0]:
                raise TypeError("only python-object expected, user-object not allowed\n"+str(type(obj)))
        else:
            ret_string += "<user-obj>"
    return ret_string


def dict_processing(obj, deep):
    ret = ""
    index = 0
    if len(obj) == 0:
        return ret
    else:
        for each in obj:
            index += 1
            ret += "\t"*deep +\
                   distributor("<class 'str'>", str(each), deep) +\
                   ": " +\
                   distributor(str(type(obj[each])), obj[each], deep) + \
                   is_last_in_dict(index, len(obj)) +\
                   "\n"
        return ret


def list_tuple_processing(obj, deep):
    ret = ""
    if len(obj) == 0:
        return ret
    else:
        for each in obj:
            ret += "\t"*deep+distributor(str(type(each)), each, deep) + is_last_in_list(each, obj) + "\n"

        return ret


def is_last_in_dict(index, length):
    if not index == length:
        return ","
    else:
        return ""


def is_last_in_list(each, obj):
    if not obj.index(each) == len(obj)-1:
        return ","
    else:
        return ""


def string_processing(obj):
    return '\"'+obj+'\"'


def num_processing(obj):
    return str(obj)


def true_false_processing(obj):
    if obj:
        return "true"
    else:
        return "false"


def null_processing():
    return "null"


class MetalBlock:
    def __init__(self):
        self.x = 2
        self.y = 3
        self.value = 50
        self.name = "f"


def main():
    block = MetalBlock()
    # d = {}
    l = [2, 4, 5, 6]
    t = ["1", ("2", [3, 2, True, 'k"e', (3, 5.9, {2: 3, 4: "4"})]), 3, 4, 5]
    d = {1: "2", 2: True, 3: 9, 4: 16}

    s = "kek"
    n = 0.0
    tr = True
    no = None

    # my_json(d)
    # my_json(l)
    my_json(t)
    # my_json(s)
    # my_json(n)
    # my_json(tr)
    # my_json(no)
    # my_json(block, True)

    # print(json.dumps(m, sort_keys=True, indent=4))
    # print(json.dumps(t, sort_keys=True, indent=4))

if __name__ == '__main__':
    main()
