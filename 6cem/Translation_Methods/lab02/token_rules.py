reserved = {
    'for': 'FOR',
    'downto': 'DOWNTO',
    'begin': 'BEGIN',
    'end': 'END',
    'do': 'DO',
    'to': 'TO',
    'string': 'TYPE_STRING',
    'integer': 'TYPE_INTEGER',
    'real': 'TYPE_REAL',
    'while': 'WHILE',
    'if': 'IF',
    'then': 'THEN',
    'else': 'ELSE',
    'and': 'AND',
    'or': 'OR',
    'write': 'WRITE',
    'writeln': 'WRITELN',
    'read': 'READ',
    'readln': 'READLN',
    'var': 'VAR',
    'const': 'CONST',
    'length': 'LENGTH',
    'inc': 'INC',
    'break': 'BREAK',
    'in': 'IN',
    'not': 'NOT'
}

tokens = [
             'IDENTIFIER',
             'NON_STRICT_COMPARISON',
             'NON_EQUALITY',
             'COMPARISON',
             'ASSIGNMENT',
             'SEMICOLON',
             'EQUALITY',
             'COLON',
             'OPEN_BRACKET',
             'CLOSE_BRACKET',
             'OPEN_SQUARE_BRACKET',
             'CLOSE_SQUARE_BRACKET',
             'NUMBER',
             'PLUS',
             'MINUS',
             'DIV',
             'MUL',
             'STRING',
             'POINT',
             'ZAPYATAYA'
         ] + list(reserved.values())


def t_IDENTIFIER(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value, 'IDENTIFIER')  # Check for reserved words
    return t


t_COLON = r':'
t_SEMICOLON = r';'
t_NON_STRICT_COMPARISON = r'(<=)|(>=)'
t_NON_EQUALITY = r'(<>)'
t_COMPARISON = r'<|>'
t_EQUALITY = r'='
t_ASSIGNMENT = r':='
t_OPEN_BRACKET = r'\('
t_CLOSE_BRACKET = r'\)'
t_OPEN_SQUARE_BRACKET = r'\['
t_CLOSE_SQUARE_BRACKET = r'\]'
t_PLUS = r'\+'
t_MINUS = r'-'
t_MUL = r'\*'
t_DIV = r'/'
t_POINT = r'\.'
t_STRING = r'".*?(?=")"'
t_ZAPYATAYA = r','
t_ignore = ' \r\t\f'


def t_error(t):
    print('Illegal character "{0}" at line {1}'.format(t.value[0], t.lexer.lineno))
    t.lexer.skip(1)


def t_NUMBER(t):
    r'[+-]?(\d+(\.\d+)?)'
    if t.value == '0':
        t.value = '0'
    elif type(t.value) is int:
        t.value = int(t.value)
    else:
        t.value = float(t.value)
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)
