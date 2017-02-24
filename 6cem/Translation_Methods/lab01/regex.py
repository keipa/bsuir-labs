import re

token = r"\[\]"
line = "[]"
if re.match(token, line):
    print("ok")
    pattern = re.compile(token, re.IGNORECASE)
    tokens = pattern.findall(line)
    print(tokens)
else:
    print("not valid")
