def initstorage():
    import re
    storage = set()
    print("Set Is on the go")
    inpt = ""
    while inpt != "exit":
        inpt = input("-->")
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
        elif inpt.split()[0] == "save":
            print("saving...")
            with open(inpt.split()[1], "w") as f:
                for each in storage:
                    f.write(each+' ')
            print("saved.")
        elif inpt.split()[0] == "load":
            storage.clear()
            print("loading...")
            with open(inpt.split()[1], "r") as f:
                for each in f.read().split():
                    storage.add(each)
            print("load.")
        elif inpt.split()[0] == "grep":
            for each in storage:
                if re.match(inpt.split()[1], each):
                    print(each, " - valid")

        else:print("err")