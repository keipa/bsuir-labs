import re
func = input("wat regexp: ")
valid = input("enter example: ")
if func == "email":
    if re.match(r"[^@]+@[^@]+\.[^@]+", valid):
        print("ok")
    else:
        print("not valid")
if func == "float":
    if re.match(r'[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?', valid):
        print("ok")
    else:
        print("not valid")
if func == "url":
    print()