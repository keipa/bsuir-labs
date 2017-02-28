import re

reserved = 'RESERVED'
integer = 'TYPE_INTEGER'
real = 'TYPE_REAL'
string = 'TYPE_STRING'
variable_name = 'VARIABLE_NAME'
math_operation = 'MATH_OPERATION'
reserved_program_char = 'RESERVED_PROGRAM_CHAR'
illegal_name = 'ILLEGAL_NAME'

ans = list()

expr = [
    (r"\bprogram\s.*",reserved),
    (r'{$APPTYPE CONSOLE}', reserved),
    (r'var', reserved),
    (r'program\s\d+;', reserved),
    (r'uses', reserved),
    (r'const', reserved),
    (r'integer', reserved),
    (r'word', reserved),
    (r'string', reserved),
    (r'real', reserved),
    (r'begin', reserved),
    (r'end', reserved),
    (r'while', reserved),
    (r'do', reserved),
    (r'if', reserved),
    (r'then', reserved),
    (r'else', reserved),
    (r'writeln', reserved),
    (r'readln', reserved),
    (r'dec', reserved),
    (r'inc', reserved),
    (r':=', reserved),
    (r'\+', math_operation),
    (r'\-', math_operation),
    (r'\*', math_operation),
    (r'\/', math_operation),
    (r'<=', math_operation),
    (r'>=', math_operation),
    (r'<', math_operation),
    (r'>', math_operation),
    (r'=', math_operation),
    (r'\(', reserved_program_char),
    (r'\)', reserved_program_char),
    (r':', reserved_program_char),
    (r';', reserved_program_char),
    (r'\[', reserved_program_char),
    (r'\]', reserved_program_char),
    (r',', reserved_program_char),
    (r'\.', reserved_program_char),
    (r'\".+\"', string),
    (r"\'.+\'", string),
    (r'\b[A-Za-z_]\w*', variable_name),
    (r'\b[-+]?\d+\.\d+', real),
    (r'\b[-+]?\d+', integer),
    (r'\[', string),
    (r'\]', string),

]


def get_tokens(line, tokens, type, line_number):
    for token in tokens:
        if token in ('+', '-', '/', '*', '(', ')', '[',']'):
            del_string = '\\' + token
        else:
            del_string = token
        line = re.sub(del_string, '', line, 1)
        ans.append((token, type, 'line: ' + str(line_number)))

    return line


if __name__ == '__main__':

    # f = open("input.txt")
    f = open("Project2.dpr")

    code = f.readlines()
    line_number = 0
    illegal_lines = []
    for line in code:
        # todo multiproc
        current_line = line.strip()
        if current_line == '':
            continue
        line_number += 1
        for token in expr:
            line = line.strip()
            pattern = re.compile(token[0], re.IGNORECASE)
            tokens = pattern.findall(line)
            line = get_tokens(line, tokens, token[1], line_number)
            if line == '':
                break

        line = line.strip()
        if line != '':
            illegal_lines.append((current_line, illegal_name, 'line: ' + str(line_number)))

    if len(illegal_lines) == 0:
        print("OK")
    else:
        print("ERROR")
        for item in illegal_lines:
            print(item)
