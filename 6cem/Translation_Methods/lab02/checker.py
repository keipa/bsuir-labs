import re

RESERVED = 'RESERVED'
NUMBER = 'NUMBER'
STRING = 'STRING'
ID = 'ID'
DELIMITER = 'DELIMITER'
ASSIGNMENT = 'ASSIGNMENT'
ARITHMETIC = 'ARITHMETIC'
DOUBLE = 'DOUBLE'

token_exprs = [
    (r'\"([^\"]+)\"', STRING),
    (r'\'([^\"]+)\'', STRING),
    (r'\.\s*\.', DOUBLE),
    (r':=\s*:=', DOUBLE),
    (r':\s*:', DOUBLE),
    (r'\*\s*\*', DOUBLE),
    (r'-\s*-', DOUBLE),
    (r'\+\s*\+', DOUBLE),
    (r'/\s*/', DOUBLE),
    (r';\s*;', DOUBLE),
    (r',\s*,', DOUBLE),
    (r'>=\s*>=', DOUBLE),
    (r'<=\s*<=', DOUBLE),
    (r'>\s*>', DOUBLE),
    (r'<\s*<', DOUBLE),
    (r'\=\s*\=', DOUBLE),
    (r'\[\s*\[', DOUBLE),
    (r'\]\s*\]', DOUBLE),
    (r'var\s*var', DOUBLE),
    (r'\bvar\b', RESERVED),
    (r'\binteger\b', RESERVED),
    (r'\breal\b', RESERVED),
    (r'\bstring\b', RESERVED),
    (r'\bchar\b', RESERVED),
    (r'\bdownto\b', RESERVED),
    (r'\bdo\b', RESERVED),
    (r'\bwhile\b', RESERVED),
    (r'\bend\b', RESERVED),
    (r'\band\b', RESERVED),
    (r'\bbegin\b', RESERVED),
    (r'\bfor\b', RESERVED),
    (r'\bif\b', RESERVED),
    (r'\bthen\b', RESERVED),
    (r'\belse\b', RESERVED),
    (r'\bwriteln\b', RESERVED),
    (r'\blength\b', RESERVED),
    (r'\bwrite\b', RESERVED),
    (r'\breadln\b', RESERVED),
    (r'\bread\b', RESERVED),
    (r'\bconst\b', RESERVED),
    (r'\binc\b', RESERVED),
    (r'\bnot\b', RESERVED),
    (r'\bin\b', RESERVED),
    (r'[A-Za-z][A-Za-z0-9_]*', ID),
    (r'[0-9]+', NUMBER),
    (r'\.', RESERVED),
    (r':=', ASSIGNMENT),
    (r':', RESERVED),
    (r'\*', ARITHMETIC),
    (r'-', ARITHMETIC),
    (r'\+', ARITHMETIC),
    (r'/', ARITHMETIC),
    (r'[mM][oO][dD]', ARITHMETIC),
    (r'[Dd][Ii][Vv]', ARITHMETIC),
    (r'\(', RESERVED),
    (r'\)', RESERVED),
    (r';', DELIMITER),
    (r',', RESERVED),
    (r'>=', RESERVED),
    (r'<=', RESERVED),
    (r'>', RESERVED),
    (r'<', RESERVED),
    (r'\=', RESERVED),
    (r'\[', RESERVED),
    (r'\]', RESERVED),
    (r'[ \n\t]+', None),
]


def check(pascal_text):
    tokens = []
    errors = []
    variables = dict()
    flag = False
    text = pascal_text.split('\n')
    for idx, line in enumerate(text):
        line_cpy = line[:]
        line_tokens = []
        for token_expr in token_exprs:
            while True:
                pattern, tag = token_expr
                matches = re.findall(pattern, line)
                for match in matches:
                    line = re.sub(pattern, '', line, 1)
                    if tag == DOUBLE:
                        errors.append((idx + 1, match))
                        continue
                    if token_expr[1] and match:
                        if match == "var" or match == "const":
                            flag = True
                        if match == "begin":
                            flag = False
                        if flag and tag == ID:
                            if line_cpy.count("=") > 0:
                                typ = line_cpy.split("=")[1][1:-1]
                                variables[match] = ("" if typ.count("\"") > 0 else 0, list)
                            elif line_cpy.count(":") > 0:
                                typ = line_cpy.split(":")[1][:-1]
                                typ1 = float
                                if typ == "string":
                                    typ1 = str
                                    variables[match] = ("", typ1)
                                elif typ == "integer":
                                    typ1 = int
                                    variables[match] = (0, typ1)
                                else:
                                    variables[match] = (0, typ1)
                        elif tag == ID and list(variables.keys()).count(match) == 0:
                            errors.append((idx + 1, match))
                            continue
                        pass
                else:
                    break
        if line == '\"\"':
            pass
        elif line:
            errors.append((idx + 1, line.strip()))
    return variables, errors
