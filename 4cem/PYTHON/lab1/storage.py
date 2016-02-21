def initstorage():
    storage = set()
    inpt = ""
    while inpt != "exit":
        inpt = input("→")
        if inpt == "list":
            print(storage)
        elif inpt.split()[0] == "add":
            for each in inpt.split()[1:]:
                storage.add(each)
            # print("added")
        elif inpt.split()[0] == "remove":
            for each in inpt.split()[1:]:
                storage.discard(each)
        elif inpt.split()[0] == "find":
            for each in inpt.split()[1:]:
                if each in storage:
                    print(each)
                else: print("There is no", each, "in list")
            # print(storage)
        else:print("err")