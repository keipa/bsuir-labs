def my_json(obj, tabs):
    what_the_obj = str(type(obj))
    s = distributor(what_the_obj, obj, 0, tabs)
    print(s)
    return 0


def distributor(objtype, obj, deep, tabs, *args):
    ret_string = ""
    if objtype == "<class 'dict'>":
        ret_string += "{\n"
        deep += 1
        ret_string += dict_processing(obj, deep, tabs)
        ret_string += "\t"*tabs*(deep-1)+"}"
        deep -= 1
    elif objtype == "<class 'list'>" or objtype == "<class 'tuple'>":
        ret_string += "[\n"
        deep += 1
        ret_string += list_tuple_processing(obj, deep, tabs)
        ret_string += "\t"*tabs*(deep-1)+"]"
        deep -= 1
    elif objtype == "<class 'str'>":
        ret_string += string_processing(obj, tabs)
    elif objtype == "<class 'int'>" or objtype == "<class 'float'>":
        ret_string += num_processing(obj, tabs)
    elif objtype == "<class 'bool'>":
        ret_string += true_false_processing(obj, tabs)
    elif objtype == "<class 'NoneType'>":
        ret_string += null_processing(tabs)
    else:
        if len(args) != 0:
            if args[0]:
                raise TypeError("only python-object expected, user-object not allowed\n"+str(type(obj)))
        else:
            ret_string += "<user-obj>"
    return ret_string


def dict_processing(obj, deep,tabs):
    ret = ""
    index = 0
    if len(obj) == 0:
        return ret
    else:
        for each in obj:
            index += 1
            ret += "\t"*deep*tabs +\
                   distributor("<class 'str'>", str(each), deep, tabs) +\
                   ": " +\
                   distributor(str(type(obj[each])), obj[each], deep, tabs) + \
                   is_last_in_dict(index, len(obj)) +\
                   "\n"
        return ret


def list_tuple_processing(obj, deep,tabs):
    ret = ""
    if len(obj) == 0:
        return ret
    else:
        for each in obj:
            ret += "\t"*tabs*deep+distributor(str(type(each)), each, deep, tabs) + is_last_in_list(each, obj) + "\n"

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


def string_processing(obj,tabs):
    obj.replace("\"", "\\\"")
    return '\"'+obj+'\"'


def num_processing(obj,tabs):
    return str(obj)


def true_false_processing(obj,tabs):
    if obj:
        return "true"
    else:
        return "false"


def null_processing(tabs):
    return "null"





def main():
    # d = {}
    l = [2, 4, 5, 6]
    t = ["1", ("2", [3, 2, True, 'ke', (3, 5.9, {2: [4,5,6], 4: "4"})]), 3, 4, 5]
    d = {1: "2", 2: True, 3: 9, 4: 16}
    print(t)

    s = "kek"
    n = 0.0
    tr = True
    no = None

    # my_json(d)
    # my_json(l)
    my_json(t, 2)


if __name__ == '__main__':
    main()
