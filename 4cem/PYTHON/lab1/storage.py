def init_storage():
    import re
    storage = set()
    print("Set Is on the go")
    input_string = ""
    while input_string != "exit":
        input_string = input("-->")
        if input_string == "list":
            print(storage)
        elif input_string.split()[0] == "add":
            for each in input_string.split()[1:]:
                storage.add(each)
            # print("added")
        elif input_string.split()[0] == "remove":
            for each in input_string.split()[1:]:
                storage.discard(each)
        elif input_string.split()[0] == "find":
            for each in input_string.split()[1:]:
                if each in storage:
                    print(each)
                else:
                    print("There is no", each, "in list")
        elif input_string.split()[0] == "save":
            print("saving...")
            with open(input_string.split()[1], "w") as f:
                for each in storage:
                    f.write(each+' ')
            print("saved.")
        elif input_string.split()[0] == "load":
            storage.clear()
            print("loading...")
            with open(input_string.split()[1], "r") as f:
                for each in f.read().split():
                    storage.add(each)
            print("load.")
        elif input_string.split()[0] == "grep":
            for each in storage:
                if re.match(input_string.split()[1], each):
                    print(each, " - valid")
        else:
            print("err")
