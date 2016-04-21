string  = "weh\nwehw\t woje"


def tabstring(ret, deep):
    split = ret.split("\n")
    for each in range(len(split)):
        split[each] = "\t"*deep+split[each]
    ret = ""
    for each in split:
        ret += each + "\n"
    return ret

print(string)
print(tabstring(string, 2))
